Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F9C50DE9B
	for <lists+linux-api@lfdr.de>; Mon, 25 Apr 2022 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiDYLT2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 Apr 2022 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbiDYLTT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Apr 2022 07:19:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C83C73B;
        Mon, 25 Apr 2022 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650885375; x=1682421375;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sJR1mNOe8X7WozLkgEphU67J123KZXsLcL2Bkf/+MWk=;
  b=M/7xH+RlfHD5b1id0Y5ZZaLKMdoULHJAhdfKDZREO7Uvxs2iyP6Yy7Aw
   MeG/jSOe+c/2T0MDUBHlGYSqy5c4zKuiwmA/w8Q4uET/ViyR87MlLICzo
   23HPvlYGuAquhZHw8M9eN8BipM30otbQXUXKISMpbNJC1MHm5HUYONJy2
   qJUbUJI/rEule6txZoDifCQX4BLufzSRbgqcAT/3UTo7QVAWs1QBX37QI
   JD3Tsdty6jYdL3WVQ7keJVKPBj1o8AKjfr9HZ/Zz4fgjFVo4ER0bJR1gB
   g32RwN71jWx3y8ICB5j+9l7SrArYedPN2JxaWiLEbm0hI6Zta1YkDQPml
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351666298"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="351666298"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:16:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="579233422"
Received: from yfriedgu-mobl.ger.corp.intel.com ([10.251.216.185])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:16:11 -0700
Date:   Mon, 25 Apr 2022 14:16:06 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vicente Bergas <vicencb@gmail.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        giulio.benetti@micronovasrl.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com,
        =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        jirislaby@kernel.org, johan@kernel.org, linux-api@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 00/12] Add RS485 support to DW UART
In-Reply-To: <CAAMcf8DQcArMRqL-uYUt-aUT-LaETn4a7+wjqeet15cFQuy3uQ@mail.gmail.com>
Message-ID: <12b796f6-faf4-dec8-772f-6eda784af493@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com> <20220421153626.120494-1-vicencb@gmail.com> <388d773-5c21-dfc9-40b1-7f2a060154d@linux.intel.com> <184ccf6c-e1db-8a64-24e0-f045a9d88751@linux.intel.com>
 <CAAMcf8DQcArMRqL-uYUt-aUT-LaETn4a7+wjqeet15cFQuy3uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-69205849-1650885375=:1634"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-69205849-1650885375=:1634
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 24 Apr 2022, Vicente Bergas wrote:

> Hi Ilpo, thank you for your quick reply with a solution!
> 
> On Fri, Apr 22, 2022 at 3:07 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Fri, 22 Apr 2022, Ilpo Järvinen wrote:
> >
> > > On Thu, 21 Apr 2022, Vicente Bergas wrote:
> > >
> > > > 1.- rs485_stop_tx is never called because there are no interrupts.
> > > > I worked around this by disabling DMA:
> > >
> > > I'll need to look into this.
> >
> > 8250 DMA tx complete path lacks calls to normal 8250 stop handling and
> > I think it probably also assumes too much from dmaengine's completion
> > callback. ...It also seems bit early to call serial8250_rpm_put_tx from
> > there(?).
> >
> > This patch allowed em485_start/stop_tx to be called in my tests:
> > [PATCH 1/1] serial: 8250: use THRE & __stop_tx also with DMA
> 
> I confirm that this patch fixes the issue when DMA is enabled.
> 
> I also confirm that your other patch
> > +                       stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);
> fixes the issue with RTS/DriverEnable deassertion time.
> I've tested it again at 19200e1 and now RTS is deasserted
> approximately at the same time as the end of the stop bit.
> Please, note the "e" for even parity bit, that extra bit after the
> data byte might have an impact on this timings.

Great, thanks again for testing.

I don't think that parity "e" makes the calculations incorrect as parity 
bit should be taken into account in tty_get_frame_size(). My guess is it's 
more about whether THRE might get asserted already during the stop bit or 
only after the stop bit has been fully sent.


-- 
 i.

--8323329-69205849-1650885375=:1634--
