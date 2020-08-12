Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1395242E02
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHLRXm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHLRXl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 13:23:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F032C061384
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 10:23:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v15so1575622lfg.6
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrY/NxWx3/FaOMH2Zu/xiJfV6Atph/3rs8H9NXO5FQo=;
        b=b+S2a3dv91gBN5p4hLlLS3kGrhtpEqptSqM9+j4RM42U/tjZlfA5rD7v6Z2qIU4kAn
         NadltzA8Fkl37lUGOrDWZW2oPmMhkKva9Jy3+735PAhqC3zlJFArnTlW4T5zxWoFCWXE
         TjA3SPWJ77pB/afeA7ZSRuw8fAxCi87MmCf9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrY/NxWx3/FaOMH2Zu/xiJfV6Atph/3rs8H9NXO5FQo=;
        b=jgfwMu+pjhzojKRBGoHdhbB3vhVdVxLvUE6FU1STLR/JvE9hS1/wXNoVX1Pok+pTpO
         /u3pCFZYnw50Xls0POMEFfPWx77kxDTkhWE0DUFPmtWbGNiDo77OALLowsXu1UWzlOni
         iBcckDZWzM5RAl8H7QotDjfdDz2KtR53Xu/18fNynLqBSAsJyC0hs7xB5kQ93ZUWgFXQ
         bXyPxZHjbCsL03gbTFCkjdBB51emPtndGU6wLWBYYgm7NnUryBBS2azoBM0yqLYjGczg
         Z4yOWtkd72Q4l3/plRO23EWFAahs1iV2hlAxez53iEB3vMQq0XXPISjsrCR4Ogq7Gk7O
         VIvA==
X-Gm-Message-State: AOAM530KAr79r9+qm3k66ZZ2Bg+VpZUXAQCWg9glxO5FZARuLBj+ifj9
        s9rMg2/sSiKuddZpkH+WmdYP49O6TFs=
X-Google-Smtp-Source: ABdhPJyyqb3DpiS18EuDCKe2RKzb+YZy4S9X7FqAZn10bx70US4lSnp78ucNG9vPIdndv29VfYDmNQ==
X-Received: by 2002:a19:a8f:: with SMTP id 137mr203673lfk.145.1597253019200;
        Wed, 12 Aug 2020 10:23:39 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y21sm608004lff.34.2020.08.12.10.23.37
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id i80so1554982lfi.13
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr215699lfa.192.1597253017201;
 Wed, 12 Aug 2020 10:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0724405aca59f64@google.com> <20200812041518.GO1236603@ZenIV.linux.org.uk>
 <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com> <20200812055558.GP1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812055558.GP1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 10:23:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkE96-0OZzAJoyJEp_J9uKuojS9K9Zo-wuU+RUOcsiKQ@mail.gmail.com>
Message-ID: <CAHk-=whkE96-0OZzAJoyJEp_J9uKuojS9K9Zo-wuU+RUOcsiKQ@mail.gmail.com>
Subject: Re: [PATCH] Re: KASAN: use-after-free Read in path_init (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 11, 2020 at 10:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 09:29:47PM -0700, Linus Torvalds wrote:
> >
> > Do you want me to apply directly, or do you have other fixes pending
> > and I'll get a pull request?
>
> Not at the moment - I can throw it into #fixes and send a pull request
> if you wish, but there won't be anything else in it...

Ok, I applied the patch directly. Thanks,

                Linus
