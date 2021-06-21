Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F433AF6F6
	for <lists+linux-api@lfdr.de>; Mon, 21 Jun 2021 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFUUsW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Jun 2021 16:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFUUsV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Jun 2021 16:48:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64CC061574
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 13:46:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id n12so6383453pgs.13
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=psYy9Fao30njPSzfDg8y5tMU1DUFT5ynRYYPNqb4lJI=;
        b=IlmvSBjS+811E5Lx6mkzOSxa0lIMSV5YqvC+MMt4coGGsfrWVNe/Mo3LGmFIwwUIJJ
         IaGhFec9cHWxmz8sAzP+oaAunmUFlMo6DSFlMAuit18Jkq8TGR7S9uIx9k9ZvbIuC8VI
         ZtTfc6pM5O/nmtNxJIzJUUhk1ky5RybnCX55n2XmZL6oPoSeeghtR4ZlRCFoifBY9Zv+
         n1yqONQYjhGk9Hx0OsvR64muGuv8xkbgtMtZE6XNJE/5UWGya+0kI+5Wrh157ciq/Tgj
         V17XPj1yEyw7fuGmbxKjxw8n5H/fD/SDhTV5odACTVzyBt9Z7bkssmo4oEBjhfRlZj0/
         DD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=psYy9Fao30njPSzfDg8y5tMU1DUFT5ynRYYPNqb4lJI=;
        b=EUCTKjizyd0mfFaxfnIkdVrtl4rMCpfsytdVPo3L8MaW2+PSknG8Jc66S0g0C/B4ih
         78ycue6eneBbCUiJBtB46q2KCZ/GNHNnApFR0dzjVXsk6tsdW55o46QJ2RIpcgVwReuU
         Qhejso460AfPu/4uX4/ueY5/fGnD+AFsWo30teMX1LL3pcFzOnVA2ivZwzRHxnU7mV4q
         NIaIAf5pz3vMRPMIrCf5aj443ZXNYjtSrET3z9LnZ+yNExoEe37+SPNtHPeVwFGkwC3r
         6HJr+VbRQpXNIruKapIdOAFaaExzhmFmAk7WTYSR8yPpPFKGwWiCn/hph/mqTuRiQx7+
         zWVg==
X-Gm-Message-State: AOAM532un5LJpaVxlezcDmQkLGc2Kxb/h95mJaStGx0c0qVCzBlFwTCx
        MWKMf0+BPQRxu/dosw1r+3m1Jg==
X-Google-Smtp-Source: ABdhPJzd21TnqnpTgGRYRK8X7zuAr8mbLjW1EBvzEei9q4qavRq9urSABKUym7ZQ1oGjF8LJpZswAA==
X-Received: by 2002:aa7:9988:0:b029:2fa:c8cd:eb66 with SMTP id k8-20020aa799880000b02902fac8cdeb66mr93525pfh.62.1624308366508;
        Mon, 21 Jun 2021 13:46:06 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:96f])
        by smtp.gmail.com with ESMTPSA id u11sm90766pjf.46.2021.06.21.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:46:05 -0700 (PDT)
Date:   Mon, 21 Jun 2021 13:46:04 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YND6jOrku2JDgqjt@relinquished.localdomain>
References: <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 21, 2021 at 12:33:17PM -0700, Linus Torvalds wrote:
> On Mon, Jun 21, 2021 at 11:46 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > How do we get the userspace size with the encoded_iov.size approach?
> > We'd have to read the size from the iov_iter before writing to the rest
> > of the iov_iter. Is it okay to mix the iov_iter as a source and
> > destination like this? From what I can tell, it's not intended to be
> > used like this.
> 
> I guess it could work that way, but yes, it's ugly as hell. And I
> really don't want a readv() system call - that should write to the
> result buffer - to first have to read from it.
> 
> So I think the original "just make it be the first iov entry" is the
> better approach, even if Al hates it.
> 
> Although I still get the feeling that using an ioctl is the *really*
> correct way to go. That was my first reaction to the series
> originally, and I still don't see why we'd have encoded data in a
> regular read/write path.
> 
> What was the argument against ioctl's, again?

The suggestion came from Dave Chinner here:
https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/

His objection to an ioctl was two-fold:

1. This interfaces looks really similar to normal read/write, so we
   should try to use the normal read/write interface for it. Perhaps
   this trouble with iov_iter has refuted that.
2. The last time we had Btrfs-specific ioctls that eventually became
   generic (FIDEDUPERANGE and FICLONE{,RANGE}), the generalization was
   painful. Part of the problem with clone/dedupe was that the Btrfs
   ioctls were underspecified. I think I've done a better job of
   documenting all of the semantics and corner cases for the encoded I/O
   interface (and if not, I can address this). The other part of the
   problem is that there were various sanity checks in the normal
   read/write paths that were missed or drifted out of sync in the
   ioctls. That requires some vigilance going forward. Maybe starting
   this off as a generic (not Btrfs-specific) ioctl right off the bat
   will help.

If we do go the ioctl route, then we also have to decide how much of
preadv2/pwritev2 it should emulate. Should it use the fd offset, or
should that be an ioctl argument? Some of the RWF_ flags would be useful
for encoded I/O, too (RWF_DSYNC, RWF_SYNC, RWF_APPEND), should it
support those? These bring us back to Dave's first point.
