Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0A265039
	for <lists+linux-api@lfdr.de>; Thu, 10 Sep 2020 22:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIJUIA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Sep 2020 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgIJUF6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Sep 2020 16:05:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBD9C061573;
        Thu, 10 Sep 2020 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=c2OmDmw3CBNdMhbSUreC74RlMC1GtRl7G6wTRWdIDhg=; b=oalS+EShumiM+wP4ntMj+va6+Q
        Nh1j9337AoOX5aS6ehlDvYBnbeH5wAQR/9ls36am10xynQpwjAzNspdirI5ohbUmCjgytsp6ExJhu
        61TqiAGlfQvDFqi1JocYtyt1E3SBqZt+RHR5ElNE0185BXyGVupHaZe0djMdV/ttf1KoyzZ8hdeFJ
        z0CoXaDzfHr5fh5hlf6Gt1AywT/4OZMjRpww4aVwjYJG+OoB5dzIFkkHg42E79TUXRRyuDmQBueyp
        KAqaQ+Hi5YPbc5abQpTeFLdmAJTJqOQETXvwfl9CDwTes6XA46M10L1IXyJSp5ODcSg+CifPThbbA
        V4gIP2hA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGSpD-0003dj-CF; Thu, 10 Sep 2020 20:05:43 +0000
Date:   Thu, 10 Sep 2020 21:05:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v9 0/3] Add introspect_access(2) (was O_MAYEXEC)
Message-ID: <20200910200543.GY6583@casper.infradead.org>
References: <20200910164612.114215-1-mic@digikod.net>
 <20200910170424.GU6583@casper.infradead.org>
 <f6e2358c-8e5e-e688-3e66-2cdd943e360e@digikod.net>
 <a48145770780d36e90f28f1526805a7292eb74f6.camel@linux.ibm.com>
 <880bb4ee-89a2-b9b0-747b-0f779ceda995@digikod.net>
 <20200910184033.GX6583@casper.infradead.org>
 <20200910200010.GF1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910200010.GF1236603@ZenIV.linux.org.uk>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 10, 2020 at 09:00:10PM +0100, Al Viro wrote:
> On Thu, Sep 10, 2020 at 07:40:33PM +0100, Matthew Wilcox wrote:
> > On Thu, Sep 10, 2020 at 08:38:21PM +0200, Micka�l Sala�n wrote:
> > > There is also the use case of noexec mounts and file permissions. From
> > > user space point of view, it doesn't matter which kernel component is in
> > > charge of defining the policy. The syscall should then not be tied with
> > > a verification/integrity/signature/appraisal vocabulary, but simply an
> > > access control one.
> > 
> > permission()?
> 
> int lsm(int fd, const char *how, char *error, int size);
> 
> Seriously, this is "ask LSM to apply special policy to file"; let's
> _not_ mess with flags, etc. for that; give it decent bandwidth
> and since it's completely opaque for the rest of the kernel,
> just a pass a string to be parsed by LSM as it sees fit.

Hang on, it does have some things which aren't BD^W^WLSM.  It lets
the interpreter honour the mount -o noexec option.  I presume it's
not easily defeated by
	cat /home/salaun/bin/bad.pl | perl -

