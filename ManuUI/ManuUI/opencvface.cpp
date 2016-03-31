
//使用了QSGSimpleTextureNode，然后我们将opencv的图像，作为一个QSGTexture，
//然后返回给渲染的线程进行场景的渲染。
//这里还要说下，Qt的QImage，不支持单通道的灰度图，我们需要转换成RGB才能正确的显示。
QSGNode* OpenCVshowFrame::updatePaintNode(QSGNode *old, UpdatePaintNodeData *)
{
    QSGSimpleTextureNode *texture = static_cast<QSGSimpleTextureNode*>(old);
    if (texture == NULL) {
        texture = new QSGSimpleTextureNode();
    }
    QImage img;
    IplImage *iplImage = NULL;
    IplImage *out = NULL;
    if (m_capture) {
        iplImage = static_cast<OpenCVcapture*>(m_capture)->getFrame();
    }
    if (iplImage != NULL) {
        out = doActions(iplImage);
        uchar *imgData = (uchar *)out->imageData;
        //qDebug() << out->depth << out->nChannels;
        img = QImage(imgData, out->width, out->height, QImage::Format_RGB888);
    } else {
        img = QImage(boundingRect().size().toSize(), QImage::Format_RGB888);
    }
    QSGTexture *t = window()->createTextureFromImage(img.scaled(boundingRect().size().toSize()));
    if (t) {
        QSGTexture *tt = texture->texture();
        if (tt) {
            tt->deleteLater();
        }
        texture->setRect(boundingRect());
        texture->setTexture(t);
    }
    if (out) {
        cvReleaseImage(&out);
    }
    return texture;
}
