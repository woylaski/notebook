/*
 * videoencoder.h -- encode the video frame based on the selected encoder
 * Copyright © 2015  e-con Systems India Pvt. Limited
 *
 * This file is part of Qtcam.
 *
 * Qtcam is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 *
 * Qtcam is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Qtcam. If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef __VideoEncoder_H
#define __VideoEncoder_H

#include <QIODevice>
#include <QFile>
#include <QImage>

/* checking version compatibility */
#define LIBAVCODEC_VER_AT_LEAST(major,minor)  (LIBAVCODEC_VERSION_MAJOR > major || \
                                              (LIBAVCODEC_VERSION_MAJOR == major && \
                                               LIBAVCODEC_VERSION_MINOR >= minor))


//#if !LIBAVCODEC_VER_AT_LEAST(54,25)
//    #define AV_CODEC_ID_NONE CODEC_ID_NONE
//    #define AV_CODEC_ID_MJPEG CODEC_ID_MJPEG
//    #define AV_CODEC_ID_RAWVIDEO CODEC_ID_RAWVIDEO
//    #define AV_CODEC_ID_H264 CODEC_ID_H264
//    #define AV_CODEC_ID_VP8 CODEC_ID_VP8
//    #define AVCodecID CodecID
//#endif

extern "C" {
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavutil/mathematics.h"
#include "libavutil/rational.h"
#include "libavutil/avstring.h"
#include "libswscale/swscale.h"
#include "libavutil/intreadwrite.h"
#include "libavutil/dict.h"
}

class VideoEncoder
{

public:
   VideoEncoder();
   virtual ~VideoEncoder();

   bool createFile(QString filename, CodecID encodeType, unsigned width,unsigned height,unsigned fpsDenominator, unsigned fpsNumerator, unsigned bitRate);
   bool closeFile();

   int encodeImage(const QImage &);
   bool isOk();

protected:
      unsigned Width,Height;
      unsigned Bitrate;
      unsigned Gop;
      bool ok;
      int i;

      // FFmpeg stuff
      AVFormatContext *pFormatCtx;
      AVOutputFormat *pOutputFormat;
      AVCodecContext *pCodecCtx;
      AVStream *pVideoStream;
      AVCodec *pCodec;

      // Frame data
      AVFrame *ppicture;
      uint8_t *picture_buf;

      // Compressed data
      int outbuf_size;
      uint8_t* outbuf;
      uint8_t* finalBuf;

      // Conversion
      SwsContext *img_convert_ctx;

      // Packet
      AVPacket pkt;

      QString fileName;
      QString tempExtensionCheck;
      unsigned getWidth();
      unsigned getHeight();
      bool isSizeValid();

      void initVars();
      bool initCodec();

      // Alloc/free the output buffer
      bool initOutputBuf();
      void freeOutputBuf();

      // Alloc/free a frame
      bool initFrame();
      void freeFrame();

      // Frame conversion
      bool convertImage(const QImage &img);
      bool convertImage_sws(const QImage &img);

};
#endif // VideoEncoder_H

