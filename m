Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8EC50B403
	for <lists+linux-api@lfdr.de>; Fri, 22 Apr 2022 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445969AbiDVJ2k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Apr 2022 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiDVJ2i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Apr 2022 05:28:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD25FC6;
        Fri, 22 Apr 2022 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650619546; x=1682155546;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1Fnolbueqw1c8NP/rVjhAwcm4M/bqVF9+bKIZ0KD2GA=;
  b=EWXkM4Ma0ApUI/Ypy5Vc9jIopdXFebC4TAH6zLhC7BpiVsjtd2lk3O8n
   R1mbTBhLxjT2ayKUkDqinwjgUgcV74UyoEuxICm03+UBUxz6nhluvDa9p
   ni+qwiJhXuiG/ZDlYnQ2way80rIGmAkRYYCnHVtN8pb0HrKb3szGbjond
   iU92+mt4kQw09gDR0QiTic0TEDtEG1gw0O88vO6iq7oXsfAkgF76t6ko6
   S+NnD9/ShF4UZvFcc5RO99i+SRJ61GXFViLDTybktwpUYNdghq5uEYDJD
   KJ8WhdFgAePhG9Fc66yYGnjCP/ANj/tV+ASG4hp3Z8p2AQ0jPygOvU6jE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262227831"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="262227831"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:25:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="556273544"
Received: from dongaris-mobl.gar.corp.intel.com ([10.252.56.39])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:25:41 -0700
Date:   Fri, 22 Apr 2022 12:25:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vicente Bergas <vicencb@gmail.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        giulio.benetti@micronovasrl.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, heiko@sntech.de,
        jirislaby@kernel.org, johan@kernel.org, linux-api@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, lukas@wunner.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v3 00/12] Add RS485 support to DW UART
In-Reply-To: <20220421153626.120494-1-vicencb@gmail.com>
Message-ID: <388d773-5c21-dfc9-40b1-7f2a060154d@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com> <20220421153626.120494-1-vicencb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-414335990-1650619544=:1779"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-414335990-1650619544=:1779
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 21 Apr 2022, Vicente Bergas wrote:

> i have tested your v3 patch on v3 hardware, that is, using the
> emulated em485 because of lack of HW support. It is not working
> due to three issues.

Thanks for testing!

> 1.- rs485_stop_tx is never called because there are no interrupts.
> I worked around this by disabling DMA:
> 
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -577,3 +577,3 @@ static int dw8250_probe(struct platform_device *pdev)
>  		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
>  		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
> - 		up->dma = &data->data.dma;
> +		up->dma = 0; // Proof of concept, not to be merged!

I'll need to look into this.

> 2.- Although "linux,rs485-enabled-at-boot-time" is set in the DTS,
> the RTS/DriverEnable line is asserted all the time the /dev/ttyS1
> device file is closed.
> As soon as the device file is openned, the RTS line is deasserted.
> Then it works as expected: it is asserted only during transmissions.
> When the device file is closed again, the RTS line goes back to the
> asserted level and stays there.
> When the rs485 mode is enabled, it is expected that the RTS line be
> deasserted by default.

Managing RTS is a mess in 8250 driver as has recently being noted. It will 
hopefully get sorted out eventually.

> 3.- The RTS line is asserted a few microseconds earlier than the
> start bit, that is acceptable, but then it deasserts one whole bit
> time before the last stop bit.
> So, the last stop bit of the last byte of a message is not sent
> because the driver is disabled.
> This has been tested with the port configured at 19200e1, that is,
> the bit time is 52 us.
> I worked around this by adding "rs485-rts-delay = <0 52>;" in the
> DTS. This leads to the following feature (not an issue):
> 
> On Mon, 11 Apr 2022 11:33:12 +0300, Ilpo Järvinen wrote:
> > Set delay_rts_before_send and delay_rts_after_send to zero for now.
> > The granularity of that ABI is too coarse to be useful.
> 
> Indeed the time unit of this parameter is milliseconds, as stated in
> Documentation/devicetree/bindings/serial/rs485.yaml
> Which in the general case is more than ten bit times.
> 
> But it is being interpreted as microseconds here:
> 
> On Mon, 11 Apr 2022 11:33:11 +0300, Ilpo Järvinen wrote:
> > [PATCH v3 02/12] serial: 8250: Handle UART without interrupt on TEMT
> >+	stop_delay += (u64)p->port.rs485.delay_rts_after_send * NSEC_PER_USEC;
> 
> So, this way it has a useful granularity to be used in
> "rs485-rts-delay = <0 52>;" but is not compliant with the spec.

It seems I just got confused here with all these different time units. My 
intention was to use NSEC_PER_MSEC here to match the spec although it's 
not that useful granularity. I'll change that for the next version.
Lukas was planning of making it much finer granularity with nsecs (leaving 
the small values for msecs for compat purposes) which would hopefully 
resolve this granularity challenge.

About the actual issue of too early deassert. It kind of sounds like the 
stop tx timer was not waiting long enough. It could be that THRE is 
asserted sooner than I expected (maybe HW does FIFO->shift register
during the transmission of the stop bit of the prev char asserting THRE
approx one bit too early).

Perhaps this patch would help to combat the problem (roughly estimating
worst-case one bit time here with that /7):

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 35fbaa53bc2f..f944c639db82 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1551,7 +1551,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		if (!(lsr & UART_LSR_TEMT)) {
 			if (!(p->capabilities & UART_CAP_NOTEMT))
 				return;
-			stop_delay = p->port.frame_time;
+			stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);
 		}
 
 		__stop_tx_rs485(p, stop_delay);
--8323329-414335990-1650619544=:1779--
