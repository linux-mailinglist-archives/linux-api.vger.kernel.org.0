Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A250B7E9
	for <lists+linux-api@lfdr.de>; Fri, 22 Apr 2022 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447733AbiDVNKT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Apr 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiDVNKS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Apr 2022 09:10:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB722B3E;
        Fri, 22 Apr 2022 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650632845; x=1682168845;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SFvPy9du95xQnOhvhD2l1NkJ/MBIRyt1xPXB/F8fRrc=;
  b=ky0MRk5Xu/+Xt8REf8KPW31uP73A4/n/v2Km4TNTtwF6Lois2V27jqQO
   BhHV3X3EyzFelstXcPwkbUG1TpdYYHMNGKJ5qvcEJlbVztmghbrl5BNPk
   8j71R0LVssKFhKts2vN1YeE+kkWFuHelLUGqx9wCc0p4UmXwY7bEV3opf
   ms6INoJ9bVQuKMBTABW/YekGd/236vWujsfYQpgaD7ZtK9ubO3r9CfzSJ
   W+WiLrCnmw8XX71GHPmwpgcVvo0R01w0Pe9sELb0LMQ/NIoVyFFhQY/Wx
   Uampz00s9nX6NmpUTw/UCPU71TWg46WjvUshXFPek95VaO8AiI8/yOteo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325123974"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="325123974"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:07:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="534279957"
Received: from dongaris-mobl.gar.corp.intel.com ([10.252.56.39])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:07:21 -0700
Date:   Fri, 22 Apr 2022 16:07:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Vicente Bergas <vicencb@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        giulio.benetti@micronovasrl.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, heiko@sntech.de,
        jirislaby@kernel.org, johan@kernel.org, linux-api@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, lukas@wunner.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v3 00/12] Add RS485 support to DW UART
In-Reply-To: <388d773-5c21-dfc9-40b1-7f2a060154d@linux.intel.com>
Message-ID: <184ccf6c-e1db-8a64-24e0-f045a9d88751@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com> <20220421153626.120494-1-vicencb@gmail.com> <388d773-5c21-dfc9-40b1-7f2a060154d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1750312257-1650632844=:1779"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1750312257-1650632844=:1779
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 22 Apr 2022, Ilpo Järvinen wrote:

> On Thu, 21 Apr 2022, Vicente Bergas wrote:
> 
> > i have tested your v3 patch on v3 hardware, that is, using the
> > emulated em485 because of lack of HW support. It is not working
> > due to three issues.
> 
> Thanks for testing!
> 
> > 1.- rs485_stop_tx is never called because there are no interrupts.
> > I worked around this by disabling DMA:
> > 
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -577,3 +577,3 @@ static int dw8250_probe(struct platform_device *pdev)
> >  		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> >  		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
> > - 		up->dma = &data->data.dma;
> > +		up->dma = 0; // Proof of concept, not to be merged!
> 
> I'll need to look into this.

8250 DMA tx complete path lacks calls to normal 8250 stop handling and
I think it probably also assumes too much from dmaengine's completion 
callback. ...It also seems bit early to call serial8250_rpm_put_tx from 
there(?).

This patch allowed em485_start/stop_tx to be called in my tests:


[PATCH 1/1] serial: 8250: use THRE & __stop_tx also with DMA

Currently, DMA complete handling in 8250 driver does not use THRE
to detect true completion of the tx and also doesn't call __stop_tx.
This leads to problems with em485 that needs to handle RTS timing.

Instead of handling tx stop within 8250 dma code, enable THRE when
tx data runs out and tweak serial8250_handle_irq to call
__stop_tx when uart is using DMA.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c  | 4 ++--
 drivers/tty/serial/8250/8250_port.c | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 890fa7ddaa7f..e84db0abf365 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -29,12 +29,13 @@ static void __dma_tx_complete(void *param)
 	xmit->tail += dma->tx_size;
 	xmit->tail &= UART_XMIT_SIZE - 1;
 	p->port.icount.tx += dma->tx_size;
+	dma->tx_size = 0;
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
 
 	ret = serial8250_tx_dma(p);
-	if (ret)
+	if (ret || !dma->tx_size)
 		serial8250_set_THRI(p);
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
@@ -71,7 +72,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
 		/* We have been called from __dma_tx_complete() */
-		serial8250_rpm_put_tx(p);
 		return 0;
 	}
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b3289ef117d1..72f144449ee1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1960,9 +1960,12 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 			status = serial8250_rx_chars(up, status);
 	}
 	serial8250_modem_status(up);
-	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE) &&
-		(up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
+		if (!up->dma || up->dma->tx_err)
+			serial8250_tx_chars(up);
+		else
+			__stop_tx(up);
+	}
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-- 
2.35.1

--8323329-1750312257-1650632844=:1779--
