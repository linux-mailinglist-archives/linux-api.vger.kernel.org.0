Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FFC22CF63
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 22:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXU0M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jul 2020 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGXU0L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jul 2020 16:26:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DE4C0619E5
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 13:26:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so1024157ljj.7
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=KtKcrijfok2OM2Bs9fSARpIOCqZAORRhOEAWEspyefuuQiv0/hudjwYFxvdZYP8RIE
         x/etcayReiFZfOvZz4a+h99awZFUCnk+gEVf5LIz5qer03CSy6o0FgWPmB4n2oXPdXJB
         lJgwEQlLR1A9JtB7EMnPQ4yBFe/eY6IWqSZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=sEYamq22w8vwLoqWw8Emsskm0CBrnqzSRclLBnU379VQ3wbjlVOTl/71jHjFldkuHb
         QUMYE0WnaCsDKJxXU4ah7xDWdcw6uZ++d2u8Ubmo3yCdRvcc4KlIDN8ypweydrwV/c3u
         Lqoeg2CFBYj0O2MRXQLcGhrMRTi2mlIBAwmE5Lw+2u29f4HbORuv8BxWGE2TCUe7UIKn
         I7uT4upta0/DCWjEcH3ovE7MG03uHSvTFx1A90vQeOiSPK2XdBC9ZYkYUGu8L6Ci/Ozp
         KScpGd3CWLadNZL6CkyKxepPhaB+oZkbwdsGKZJeqwiADZnLK1o/9uI6LeaW7aHDBj19
         As5g==
X-Gm-Message-State: AOAM5328VZSd2unkpz3RbvwxJ06xBzmsX/2NSa4KBrPgtHyWrE+WtdlZ
        IarAma5JiipS9JOI95os5FT8VsPsUDg=
X-Google-Smtp-Source: ABdhPJwjRRkWnX0NxsT+bn2H5wtrLngL+cr+Yl+k46O5X4VdK3SEIzpZ4vNI0aK2t1tcdNB20Un9zg==
X-Received: by 2002:a2e:997:: with SMTP id 145mr4583182ljj.298.1595622368309;
        Fri, 24 Jul 2020 13:26:08 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 204sm556960lfm.86.2020.07.24.13.26.06
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:26:07 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a27so1748939ljn.8
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr4879223ljj.102.1595622366366;
 Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
 <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
 <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com> <2189056.1595620785@warthog.procyon.org.uk>
In-Reply-To: <2189056.1595620785@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 13:25:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute
 change notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 24, 2020 at 12:59 PM David Howells <dhowells@redhat.com> wrote:
>
> That's a good point.  Any suggestions on how to do it?  An additional RLIMIT?
>
> Or should I do it like I did with keyrings and separately manage a quota for
> each user?

I'd count them per user, and maybe start out saying "you can have as
many watches as you can have files" and just re-use RLIMIT_NOFILE as
the limit for them.

And if that causes problems, let's re-visit. How does that sound?

                Linus
