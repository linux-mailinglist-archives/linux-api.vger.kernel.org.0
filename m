Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E734263AE6
	for <lists+linux-api@lfdr.de>; Thu, 10 Sep 2020 04:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIJCsc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Sep 2020 22:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIJB7S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Sep 2020 21:59:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B5C0617AB;
        Wed,  9 Sep 2020 18:59:18 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a12so4627586eds.13;
        Wed, 09 Sep 2020 18:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUjP7eOEkjBWCnPcsNMyT+WrVYzF6LJucKB9IpolFOQ=;
        b=npIm4mdF6gzt7Jf+4i3ecdhlURjcoZac3a6SZy5gydDgPT32Pdh5LfTKOZdp0JRZNz
         h8vVJHnYFFxtj8sTm30CJImU57l8Hg7EIIAUwMaNSik9HWYmQC0Xj2+7aCam0DJrkBDV
         jdMBWbTXHKJk3t9o741EDeY2Qb7Wjn10OcpzGsNPLMwU6JT5UFv/gYIn3wkPAjk0xdLw
         1TbCrEmAwPBMQL4OY37ol0O5vqcbSLcBO9y+m5KtIqQtY4/m8YrVp8jOQHZZR4g+Ojx5
         GCeHowcWMPR9QdUwUX1Q43T8zkUsyAA7Jpb0HNA8lEg/+arImSrrf1e1oNHlljI+w67M
         zYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUjP7eOEkjBWCnPcsNMyT+WrVYzF6LJucKB9IpolFOQ=;
        b=YFVS6P84b6Nb3qSBo/JIds+sFO6wY5rhRcWRvVR477zYQHJa/ArNRF6JX/tariJd3t
         6zh3eeBE4Cxt6jYRYV9p0zk+fRTotAdoq3RYIkQvnXycYKYGt8iYGFImxFCzNw6wGjRz
         T9OVaWEC62Ah+WJTm5uUk/lVPGfDJS+5gE8ISY/umnMktZ/DJk+K21t3UmnX8AQPfpZE
         OmEdc1M/kwSpf02g2HpsGSYa3XQn2c4aOUH+kWzEJhm2OONYmJzXzOZRVl8KqQKMwAaj
         XG43+W+pd0fQQfDjWngqiE1hJIU9iXMnbLUtSKQUPzqwKiaAcEtKX2jm0wyXuWAIj+lp
         UtHQ==
X-Gm-Message-State: AOAM532zdhU6tS5wWJFuKpnrGkiibt/mB8DFbdBP41+ZUB8JJVUv6uIM
        Cf7qyfrhDbxx3AT49fbqm4Ph6Y1LKTpE2pVSTZkgmWdX
X-Google-Smtp-Source: ABdhPJyIlIV8kCXW7pbNF74CPJLFQm0lE0AK4ZTGite4N5UAKt1ax8TSQaB6dd6XQQT2E5PjMBrdlxylZqVYBTuxVzs=
X-Received: by 2002:aa7:d458:: with SMTP id q24mr7198738edr.23.1599703156952;
 Wed, 09 Sep 2020 18:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com>
 <20200907060927.GA18909@lst.de> <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
 <20200908084258.GA17030@lst.de>
In-Reply-To: <20200908084258.GA17030@lst.de>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Thu, 10 Sep 2020 09:59:05 +0800
Message-ID: <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com>
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

If we rename it to e.g. SG_GET_MAX_XFER_BYTES, it will still break
applications unless we also keep the wrong/ugly/confusing name (and
you lose the advantage/generality that the two ioctls can be used on
both sg and "pure" block devices; which seems to be the case of some
SG_* ioctls as well).

I don't see what it has to do with passthrough. Either way, it's just
a matter of whether you want to decouple it and make things more
flexible. The only real disadvantage is, you will have to do two
ioctls instead of one, but no more than that, and for good reasons.

I don't really care enough though. I mean, I'm okay with
SG_GET_MAX_XFER_BYTES *and* NO "improper" BLKSECTGET. If that will get
the patch series in, I am willing to send a new version. If not, I'm
just gonna drop this.

On Tue, 8 Sep 2020 at 16:43, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Sep 07, 2020 at 05:01:34PM +0800, Tom Yan wrote:
> > Feel free to omit this. But then you will probably want to ditch
> > BLKSECTGET as well, and then any usage of queue_max_sectors(), and
> > maybe more/all queue_*().
> >
> > I'm not really interested in discussing/arguing whether
> > general/ideally-speaking it's appropriate/necessary to keep BLKSECTGET
> > / add BLKSSZGET. The only reason I added this is that, when BLKSECTGET
> > was introduced to sg long time ago, it was wrongly implemented to
> > gives out the limit in bytes, so now when I'm fixing it, I'm merely
> > making sure that whatever has been relying on the ioctl (e.g. qemu)
> > will only need to do one more ioctl (instead of e.g. doing SCSI in its
> > non-SCSI-specific part), if they want/need the limit in bytes. If they
> > can be implemented more "generic"-ly, feel free to improve/extend them
> > to make them "SG_*-qualified".
> >
> > Even if you can do SCSI from the userspace, or even should, I don't
> > see any reason that we shouldn't provide an ioctl to do
> > queue_logical_block_size() *while we provide one to do
> > queue_max_sectors()*.
>
> Well, the different definition in bytes for sg actually makes sense
> to me, as a bytes based limit is what fundamentally makes sense for
> the passthrough interface.  Only that it reuses the same cmd value
> is a bit confusing.  So instead of changing anything and potentially
> breaking applications I'd suggest to just better document the semantics.
