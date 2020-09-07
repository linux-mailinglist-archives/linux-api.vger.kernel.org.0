Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488E025F5EA
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgIGJBt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgIGJBt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 05:01:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCFCC061573;
        Mon,  7 Sep 2020 02:01:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t16so7208575edw.7;
        Mon, 07 Sep 2020 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9trCb+/NMrlBO+YeMAVjtwXhSPiV/QwbGusZnE12Aqs=;
        b=K4/D1evvjZalgr9BMI4o8W1xzy99FhHD/LL3ht79batJuLo27KIKEYUBLI8z1nG029
         EkI4hRCG8s+JsJGO16PbUuMXo4N00AbQJ4u+VNisvvphcPeq7HIa9zlubw6vr6qff3AD
         l9GR4Ab3vjmxTKaJRS5Q90/8JJ6jJDnBfcVII0Fc14aa+CRxFZW/kPZXV4hTcVmMOcN5
         /dOOz1VnPjqzqd69HbIRbEssJwUEa6s/pKirj4gSwOuug0/BlV70eScgXsB3aHPBvGeE
         acNf+C89Z6UQVx3uLKZyvRZbWqKxoZbqYJDgfZX6EKKGFQ8WLhjkRKDAdDG0rOxeas7N
         m64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9trCb+/NMrlBO+YeMAVjtwXhSPiV/QwbGusZnE12Aqs=;
        b=VWmKXTc3NdeZOWvAXxr7Zbt9HLITQo7bOWZxNOu+WGg0ahMhnh33tutB14gslnoz3Y
         1tG6bKPw/dLKlx0QotJQfoGQ8c72ImUXOMrs7n0ggM2V422GcBgH50TC//dZ6y9m8UfY
         k9a5u6ogDU/ovNfCgkv1LLYmNcPNvFtcCZC0mxStGd9DbHyD2RnXWnXaAUj0t8z8k6KI
         w32N76awc9Io1mAnjLQ5Dfs9LSM8AwT34/kXimG9qA283pHGqgLisjLtkpuefdhigWq6
         N62wdCVO5JbeilA/pUxQrgRMRB5Oewz9PdRIJoVB7AbFPLYFAaMX8TvS8XbqQCs65HgC
         wTwQ==
X-Gm-Message-State: AOAM533zsyDF1TCdxTF5q+hssVx1In9IA6gjxflLpfVxpg8N3r7+A3i2
        MaKwreenbfIPvbxNuNCCVNPatUsfqxb9koMQEeI=
X-Google-Smtp-Source: ABdhPJxoABDVn5TA8s4+V7jNkWwfaSuDGs2TweZ/9HhzHPyrC+plqoeJ8i6qnIrPXFfiEGunlRdnTF0qjfAi1nXg+Wo=
X-Received: by 2002:a05:6402:138a:: with SMTP id b10mr20594423edv.113.1599469305542;
 Mon, 07 Sep 2020 02:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com>
 <20200907060927.GA18909@lst.de>
In-Reply-To: <20200907060927.GA18909@lst.de>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Mon, 7 Sep 2020 17:01:34 +0800
Message-ID: <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
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

Feel free to omit this. But then you will probably want to ditch
BLKSECTGET as well, and then any usage of queue_max_sectors(), and
maybe more/all queue_*().

I'm not really interested in discussing/arguing whether
general/ideally-speaking it's appropriate/necessary to keep BLKSECTGET
/ add BLKSSZGET. The only reason I added this is that, when BLKSECTGET
was introduced to sg long time ago, it was wrongly implemented to
gives out the limit in bytes, so now when I'm fixing it, I'm merely
making sure that whatever has been relying on the ioctl (e.g. qemu)
will only need to do one more ioctl (instead of e.g. doing SCSI in its
non-SCSI-specific part), if they want/need the limit in bytes. If they
can be implemented more "generic"-ly, feel free to improve/extend them
to make them "SG_*-qualified".

Even if you can do SCSI from the userspace, or even should, I don't
see any reason that we shouldn't provide an ioctl to do
queue_logical_block_size() *while we provide one to do
queue_max_sectors()*.

On Mon, 7 Sep 2020 at 14:09, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Sep 06, 2020 at 09:27:14AM +0800, Tom Yan wrote:
> > Provide an ioctl to get the logical sector size so that the maximum
> > bytes per request can be derived.
> >
> > Follow-up of the BLKSECTGET fix.
>
> I don't think this has any business going in.  /dev/sg is a generic
> interface that is not specific to block based command sets.  Just issue
> your command set specific command to query the logical block size if
> you care about it.
