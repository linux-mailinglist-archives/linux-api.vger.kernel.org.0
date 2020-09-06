Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2325ED14
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIFHCB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHCA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:02:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490BEC061573;
        Sun,  6 Sep 2020 00:02:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so13758070ejf.6;
        Sun, 06 Sep 2020 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vr2PbFN30tGELTH+LK7AIi6ypvQ7Zp9ftW6gjejridc=;
        b=XlNLUw+ttYFc57s71jW5YLNORW5FPKRAJlSK2igpD267sgF4bYZQAWrfg2nbloWHiK
         cwM6mhUjzIS6f8ukLyE/EOMO5EBM3KXTmpfvaZK6Pg5zO6Dy65zhmfd3Qaxagy9xRpgm
         2eXnoJYGAGyWjz5mwI+JJGIcuj34Fq/7MA8FupsNF+hD4Awu3d7twnHItPJ3LRymKw/C
         bIGyVon+UDc9BcLG7kwAlsMiMTDBdrRDKNZO8GGL7paOibjoP3EGq3Hjx/27tf7mXz/a
         uXdn9LDF5A5KuIh9Dh0NSvPMtu7AZvB0vo0Notv2MKzuTw0Z3Is/+xx8xv/2M0+VzMfY
         wExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vr2PbFN30tGELTH+LK7AIi6ypvQ7Zp9ftW6gjejridc=;
        b=Zhyy3cUMZITp3xOzy6Gp0ESJvYhFOU66jJMu4bncGS5cC8fRSd6vrYezGtprvXw5au
         RgsSi6ExVHek1Hw4LYkjILmLWP0+/NQ9PhuUsw2PI5nixE7kWTxqJgfo7+2fCaIlwFFJ
         uTIkV5XXyGkHZg9dQUd5igv4+gixd7gudFNyWedbm5T99m0WELpwlyGvmXpNfUBplLZm
         7HO+VYj5cTn9WiVJqab64hIe8cK4xZb/+PIYrHI7kYlPmtc+LoHko89F54BbG4SiGooO
         3r1T9fhQ8LUsqCcHpBXwMQQlOI//60eTX5A+kcJso02GK1JjxArP0pMTluqxNxtYO3Na
         OIIA==
X-Gm-Message-State: AOAM533uXhRi7u45OHwxIyZHRk9gwkyeYDJQEoPdy2oTPulPYVicz5G2
        daGaZuRnMU0+C27zyYvTin5CuA9lZaoMYppz9D+7od+7se0=
X-Google-Smtp-Source: ABdhPJwlt3uUjOHrz+Yq84Sv6AYW4GCKo344CcQv2kLwF92ZMkRfX2OV1zCv1dd+eMLn+5wzD9Z8+xLyijtGEwqCjT8=
X-Received: by 2002:a17:906:5488:: with SMTP id r8mr15081278ejo.483.1599375718711;
 Sun, 06 Sep 2020 00:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-3-tom.ty89@gmail.com>
 <20200906062646.GA200844@kroah.com>
In-Reply-To: <20200906062646.GA200844@kroah.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Sun, 6 Sep 2020 15:01:46 +0800
Message-ID: <CAGnHSEmos_vznm40WfnX0XC-kdOKz9CNdW9thWzepkgS2eEDCw@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/4] scsi: sg: use queue_logical_sector_size() in max_sectors_bytes()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, akinobu.mita@gmail.com,
        hch@lst.de, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The resend is done to add linux-api@vger.kernel.org to the CC list. I
also removed some CC because the email addresses no longer exist (and
accidentally made a typo to one that still does, hence the second
resend). I don't know if that counts as a change.

I didn't think 3/4 and 4/4 requires further explanation, as I thought
they are self-explanatory enough (logical sector size has never been,
or at least is no longer, necessarily 512). I can add that to the
commit message.

P.S. Even I myself isn't exactly sure what/which clamping should be
used in max_sectors_bytes(). The reason I picked USHRT_MAX is that
BLKSECTGET in sg should work identically to its equivalence in the
block layer, regardless of whether that is
technically/programmatically necessary. So I decided to use the same
clamping in max_sector_bytes(). But it seems fine/correct to clamp
(max_sectors * logical_sector_size) to INT_MAX instead
(https://github.com/torvalds/linux/blob/v5.9-rc3/block/blk-mq.c#L3211).
(On the other hand, in that case it could end up being inconsistent to
what BLKSECTGET + BLKSSZGET reports). Perhaps I should add my
uncertainty / the alternative to the commit message.

Regards,
Tom

On Sun, 6 Sep 2020 at 14:26, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Sep 06, 2020 at 09:27:15AM +0800, Tom Yan wrote:
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > ---
> >  drivers/scsi/sg.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> I know I don't take patches without any changelog text at all, but maybe
> the scsi maintainers are more leniant.
>
> You should write changelogs that explain _why_ you are doing what you
> are doing, you just say what you did, with no reasoning at all.
>
> Same for another patch in this series.
>
> thanks,
>
> greg k-h
