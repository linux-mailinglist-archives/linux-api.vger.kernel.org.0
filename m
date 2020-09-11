Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B9265727
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 04:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIKCwg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Sep 2020 22:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgIKCwe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Sep 2020 22:52:34 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F4C061573;
        Thu, 10 Sep 2020 19:52:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so8393165edo.10;
        Thu, 10 Sep 2020 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rh9Pt7YWiJuvraTJEw+iENa93uiuxFqswvg59VFnc6k=;
        b=sMzIJ5FGHMBaziTx/PNmiVfjtuRIgGHsCfOiukKXUtWWDXqx4zyi+l46IaqToLBYD5
         o/7T07SKyvvJ4LV+5gVMpFsimNbwSQxj4Qe9OqarblX5aGy733vSPZZgHwhUIOF/3Y27
         B2hZz8oRU9+PmjrohSC1fKeyrkbAeB1UKBYkMDo8NMCfK3etSog31MlBRUhspJJDE6c6
         2jNW8wZnEwPCXTghUymxPbck0Dt5poc6oBj+zLm6aHlzx2Ii6gV7eyAWZnmsyA+Q3iWJ
         rmilZVDNVS1AGqphtuFkqBDkKz2KGoXifDXAlvZCtVH4BR+XUD3/pb3EGEjka+LAZv4R
         pR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rh9Pt7YWiJuvraTJEw+iENa93uiuxFqswvg59VFnc6k=;
        b=oCdIvTJiQnvqbsWHH0wfIq+yzpAQkVdgvA/YngQuGfO15cUl4k7+YGqrtrjJnt14Vj
         NyqX5loaZ98uAQp+RG1tg4K5K+JLTcpG/fy/TE/CbDBxr7RE3LEnQ/UN6FNSGSHsCn7A
         7s3OZShyWtx2HxPAAOsKUyFdVeYYJzEOV4fgkWUbx/8cpS12jlvHg981bcf4nV3fxmeM
         WVm+CQwvEyLcR86lhgMg4p+L02yKQaz5p/o4MZsRROi77r8SfGfeUI/rXyS3oRODRQco
         I7KOdK99Fa0FRGK6ExW5Ke7GIkTLS+UYY24tQkzpLqdo/7haFG/UPD1DGP76cqEm0w8J
         kwwg==
X-Gm-Message-State: AOAM5320a+t4HYvPgw+QagPjvIpjgvjYyxANCGnagCb/QTH7wu9atInY
        LOV9TnjIfPHxydbK8uM6QSz4p4JGCeh4HT/JPeg=
X-Google-Smtp-Source: ABdhPJyvdhO2E+WIGNANGbpMRpyYJJsV/39TVNMjyh7xPuRhfmQw80nfT6TjdyzpW+P6aj1Q4yDgB0e2hFy/k3AOr/E=
X-Received: by 2002:a50:fb15:: with SMTP id d21mr13117595edq.150.1599792751820;
 Thu, 10 Sep 2020 19:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com>
 <20200907060927.GA18909@lst.de> <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
 <20200908084258.GA17030@lst.de> <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com>
 <20200910052835.GB18283@lst.de>
In-Reply-To: <20200910052835.GB18283@lst.de>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Fri, 11 Sep 2020 10:52:19 +0800
Message-ID: <CAGnHSE=pcW0zJMSaowdsRXFa=TmOeidekgvDuEPB8PU7mheXNA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, akinobu.mita@gmail.com,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 10 Sep 2020 at 13:28, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Sep 10, 2020 at 09:59:05AM +0800, Tom Yan wrote:
> > If we rename it to e.g. SG_GET_MAX_XFER_BYTES, it will still break
> > applications unless we also keep the wrong/ugly/confusing name (and
> > you lose the advantage/generality that the two ioctls can be used on
> > both sg and "pure" block devices; which seems to be the case of some
> > SG_* ioctls as well).
>
> How is that an advantage?  Applications that works with block devices
> don't really work with a magic passthrough character device.

You must assume that there are applications already assuming that
work. (And it will, at least in some cases, if this series get
merged.)

And you have not been giving me a solid point anyway, as I said, it's
just queue_*() at the end of the day; regardless of whether those
would work in all sg cases, we have been using them in the sg driver
anyway.

And it's not like we have to guarantee that (the) ioctls can work in
every case anyway, right? (Especially when they aren't named SG_*).

I mean, what's even your point? How do you propose we fix this? Should
we just leave it broken/wrong/rotten as-is (including the case that
you don't consider it being so)? If that's what you are trying to say
then please just say it, I'll just walk away quietly. I'm really kind
of done with this sort of looping that leads to nowhere.

>
> > I don't really care enough though. I mean, I'm okay with
> > SG_GET_MAX_XFER_BYTES *and* NO "improper" BLKSECTGET. If that will get
> > the patch series in, I am willing to send a new version. If not, I'm
> > just gonna drop this.
>
> You must assume that there are applications already that depend in the
> "weird" BLKSECTGET on sg, given that it has been around so long.  Any
> change to the semantics will break them.

While you forgot to assume that there are applications assuming
BLKSECTGET is as "weird" in the block layer at the same time. (That's
exactly what has happened in qemu.) You don't get the slightest
advantage in "trying not to break things" by doing the wrong thing. It
only goes on making more things broken.
