Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1163AF634
	for <lists+linux-api@lfdr.de>; Mon, 21 Jun 2021 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhFUTfy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Jun 2021 15:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFUTfw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Jun 2021 15:35:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB0C061756
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 12:33:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r16so26831591ljk.9
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98EcZzJAEvwRGhhKLNlxF7bNWoPly+J/KTe1I18WcDU=;
        b=EO52yign9KUWZu3xYLUFB3FuxnN5uFqkVThdV5aZoistnd4+PDKU3CrtQ3+Vp2rIGp
         HQMteXB/U6V3Dxa02zV2sk7QVO6gwfXU+hFgQSd2jszM4P2vDZEogEx6N22jas8DawNv
         Kkjz90R5GuK/o5l8zrHDJ2yY4HQBhYbCkZFSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98EcZzJAEvwRGhhKLNlxF7bNWoPly+J/KTe1I18WcDU=;
        b=p3wlqGnUnPEerQxRJTPRRpFkKqgBs4howHmDgjrRJs73Xs5OFtKyYd+8TUY7RyiA8y
         sc+4kSrI3D86aXCj+uw1ytPn24So8K8Plwk+dDPWgypQdL15fenqRndRSetWb2rfdX9y
         03WKnbvZzRy6O2b6viVt/Y4C+6wYsP4AdebvvD9kH3tOiD6pu3ebqzTBYhC6hn7DrbPJ
         jzerOq3J2CIeyafw50YtD4sizuSnWTBhpCoslnnwCQj71PAcU7PySpZcJ399wkCCIj31
         UGeMx1IUu2yX0kzy2HBk58fjbzHUsEfMhpeSnsQHfSipkWf3LRwVV2c3s16htEsSWz+0
         V5tQ==
X-Gm-Message-State: AOAM533sxQBGQy0cuzn+Z+fUH07TuChln0opl2Ovz4O7a91o+HHEVd3/
        9laciEBTmNUcy37H/uqWhHuW1PI76mjmiOGB+4g=
X-Google-Smtp-Source: ABdhPJyhAJ1PrpymwOhs9+Vy0/YxCadR6bl2aqeYATufkoOyZFJvGOLNQPa7AhpB568eVUudFA+jNg==
X-Received: by 2002:a2e:9252:: with SMTP id v18mr23891912ljg.122.1624304014999;
        Mon, 21 Jun 2021 12:33:34 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g12sm1964524lfu.48.2021.06.21.12.33.34
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 12:33:34 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id d2so26864619ljj.11
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 12:33:34 -0700 (PDT)
X-Received: by 2002:a2e:7a14:: with SMTP id v20mr22531511ljc.465.1624304013992;
 Mon, 21 Jun 2021 12:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk> <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk> <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk> <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain> <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain> <YNDem7R6Yh4Wy9po@relinquished.localdomain>
In-Reply-To: <YNDem7R6Yh4Wy9po@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 12:33:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
Message-ID: <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 21, 2021 at 11:46 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> How do we get the userspace size with the encoded_iov.size approach?
> We'd have to read the size from the iov_iter before writing to the rest
> of the iov_iter. Is it okay to mix the iov_iter as a source and
> destination like this? From what I can tell, it's not intended to be
> used like this.

I guess it could work that way, but yes, it's ugly as hell. And I
really don't want a readv() system call - that should write to the
result buffer - to first have to read from it.

So I think the original "just make it be the first iov entry" is the
better approach, even if Al hates it.

Although I still get the feeling that using an ioctl is the *really*
correct way to go. That was my first reaction to the series
originally, and I still don't see why we'd have encoded data in a
regular read/write path.

What was the argument against ioctl's, again?

To me, this isn't all that different from the fsverity things we
added, where filesystem people were happy to try to work out some
common model and add FS_IOC_*_VERITY* ioctls.

               Linus
