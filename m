Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A150CE15
	for <lists+linux-api@lfdr.de>; Sun, 24 Apr 2022 02:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiDXABC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Apr 2022 20:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiDXABB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Apr 2022 20:01:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C951B12F0;
        Sat, 23 Apr 2022 16:58:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r189so20945915ybr.6;
        Sat, 23 Apr 2022 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fIHHdUuOlbEwHus1fULjq7tU/MfOEnBwDt9hmUUpkCc=;
        b=SMdtBNeF+0x3PGDDxjx48vZ8Xmb1d14J6giSiP5i0bDY0tdjWhUtcXuWKEcmy7sf6i
         i61tzo4nIz4zy06ik/p69nmmrNaM8NNe9yAdKTDCGDnxRnemjjCz16ODdIqU2IvjhzHm
         7JA/Te7VezzQgY1+KGMKAitEZ4/kuUh2WdZXALzQJP0uk7iL63QAy2rWI8zW5nWImldj
         MdxmyhBKPN75y8bicCDQ4ziIpXY03HtMB7uwBtOtTu2HBEUkw2QNwgk5z1Gp9ekbjjfU
         o+K72Jo0YLvBQNhoEVHGFgpCwqA9KVG9oyZZ51sxeDIlq0Zkub2jf35BJ/ysqtqS0CWs
         2P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fIHHdUuOlbEwHus1fULjq7tU/MfOEnBwDt9hmUUpkCc=;
        b=pRfweIzCA45gbKtz1NRfy3Ad8VE7FD8vU9hsj3eEBEC+CSTFBOFg8syKLfApaN0LaL
         R1+yka6mOAsWLRixdiM6i2XKHRDrbvjy0jL3DZ+d3kGZDyYwclpnHxG+gkXIAt/o/gHw
         +V6cNc4pSoQyjp2nWMrFjH7qUOTH2mj2XIOaDkvIl9pYU6drUrL9+eCJJ2sjGMo3OVaS
         3zmARiMEDtp6K5TKjYxHqKVk9L3Loiy8+mfZFT6a9N20SnfEzKIc8frW7dpCA8c8Gds/
         C/Q7eO484msraJsA5GXruPyuP4bqahUlc+TIyb2KregAHs6CE4qRHZlhGxIIMLdWqlxT
         ZE0g==
X-Gm-Message-State: AOAM5327nTwlmQVecr38xBfJPlREPuMrF9/QbHrytfxJFc5OVaV5qUfJ
        a/24Yl66PMlbwhPquAoz4C1iNXP6NWzWlzXR6yo=
X-Google-Smtp-Source: ABdhPJxUjuPQeYdT0xaYFrTWVghnxgpTJRVc1QHLaHaty4770e/O2OrSEdm7YsjbDdhCtMwxHM7TAZWgDAH13osBz/w=
X-Received: by 2002:a25:1f0a:0:b0:645:75c7:52d5 with SMTP id
 f10-20020a251f0a000000b0064575c752d5mr10070523ybf.440.1650758281731; Sat, 23
 Apr 2022 16:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220421153626.120494-1-vicencb@gmail.com> <388d773-5c21-dfc9-40b1-7f2a060154d@linux.intel.com>
 <184ccf6c-e1db-8a64-24e0-f045a9d88751@linux.intel.com>
In-Reply-To: <184ccf6c-e1db-8a64-24e0-f045a9d88751@linux.intel.com>
From:   Vicente Bergas <vicencb@gmail.com>
Date:   Sun, 24 Apr 2022 01:57:50 +0200
Message-ID: <CAAMcf8DQcArMRqL-uYUt-aUT-LaETn4a7+wjqeet15cFQuy3uQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Add RS485 support to DW UART
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        giulio.benetti@micronovasrl.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        jirislaby@kernel.org, johan@kernel.org, linux-api@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Ilpo, thank you for your quick reply with a solution!

On Fri, Apr 22, 2022 at 3:07 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 22 Apr 2022, Ilpo J=C3=A4rvinen wrote:
>
> > On Thu, 21 Apr 2022, Vicente Bergas wrote:
> >
> > > 1.- rs485_stop_tx is never called because there are no interrupts.
> > > I worked around this by disabling DMA:
> >
> > I'll need to look into this.
>
> 8250 DMA tx complete path lacks calls to normal 8250 stop handling and
> I think it probably also assumes too much from dmaengine's completion
> callback. ...It also seems bit early to call serial8250_rpm_put_tx from
> there(?).
>
> This patch allowed em485_start/stop_tx to be called in my tests:
> [PATCH 1/1] serial: 8250: use THRE & __stop_tx also with DMA

I confirm that this patch fixes the issue when DMA is enabled.

I also confirm that your other patch
> +                       stop_delay =3D p->port.frame_time + DIV_ROUND_UP(=
p->port.frame_time, 7);
fixes the issue with RTS/DriverEnable deassertion time.
I've tested it again at 19200e1 and now RTS is deasserted
approximately at the same time as the end of the stop bit.
Please, note the "e" for even parity bit, that extra bit after the
data byte might have an impact on this timings.

Regards,
  Vicente.

On Fri, Apr 22, 2022 at 3:07 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 22 Apr 2022, Ilpo J=C3=A4rvinen wrote:
>
> > On Thu, 21 Apr 2022, Vicente Bergas wrote:
> >
> > > i have tested your v3 patch on v3 hardware, that is, using the
> > > emulated em485 because of lack of HW support. It is not working
> > > due to three issues.
> >
> > Thanks for testing!
> >
> > > 1.- rs485_stop_tx is never called because there are no interrupts.
> > > I worked around this by disabling DMA:
> > >
> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > @@ -577,3 +577,3 @@ static int dw8250_probe(struct platform_device *p=
dev)
> > >             data->data.dma.rxconf.src_maxburst =3D p->fifosize / 4;
> > >             data->data.dma.txconf.dst_maxburst =3D p->fifosize / 4;
> > > -           up->dma =3D &data->data.dma;
> > > +           up->dma =3D 0; // Proof of concept, not to be merged!
> >
> > I'll need to look into this.
>
> 8250 DMA tx complete path lacks calls to normal 8250 stop handling and
> I think it probably also assumes too much from dmaengine's completion
> callback. ...It also seems bit early to call serial8250_rpm_put_tx from
> there(?).
>
> This patch allowed em485_start/stop_tx to be called in my tests:
>
>
> [PATCH 1/1] serial: 8250: use THRE & __stop_tx also with DMA
>
> Currently, DMA complete handling in 8250 driver does not use THRE
> to detect true completion of the tx and also doesn't call __stop_tx.
> This leads to problems with em485 that needs to handle RTS timing.
>
> Instead of handling tx stop within 8250 dma code, enable THRE when
> tx data runs out and tweak serial8250_handle_irq to call
> __stop_tx when uart is using DMA.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c  | 4 ++--
>  drivers/tty/serial/8250/8250_port.c | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250=
/8250_dma.c
> index 890fa7ddaa7f..e84db0abf365 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -29,12 +29,13 @@ static void __dma_tx_complete(void *param)
>         xmit->tail +=3D dma->tx_size;
>         xmit->tail &=3D UART_XMIT_SIZE - 1;
>         p->port.icount.tx +=3D dma->tx_size;
> +       dma->tx_size =3D 0;
>
>         if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>                 uart_write_wakeup(&p->port);
>
>         ret =3D serial8250_tx_dma(p);
> -       if (ret)
> +       if (ret || !dma->tx_size)
>                 serial8250_set_THRI(p);
>
>         spin_unlock_irqrestore(&p->port.lock, flags);
> @@ -71,7 +72,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>
>         if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
>                 /* We have been called from __dma_tx_complete() */
> -               serial8250_rpm_put_tx(p);
>                 return 0;
>         }
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index b3289ef117d1..72f144449ee1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1960,9 +1960,12 @@ int serial8250_handle_irq(struct uart_port *port, =
unsigned int iir)
>                         status =3D serial8250_rx_chars(up, status);
>         }
>         serial8250_modem_status(up);
> -       if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE) &&
> -               (up->ier & UART_IER_THRI))
> -               serial8250_tx_chars(up);
> +       if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
> +               if (!up->dma || up->dma->tx_err)
> +                       serial8250_tx_chars(up);
> +               else
> +                       __stop_tx(up);
> +       }
>
>         uart_unlock_and_check_sysrq_irqrestore(port, flags);
>
> --
> 2.35.1
