Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5597F25F550
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 10:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgIGIdX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 04:33:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56428 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgIGIdU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 04:33:20 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFCaP-0003zW-JD; Mon, 07 Sep 2020 08:33:13 +0000
Date:   Mon, 7 Sep 2020 10:33:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20200907083312.33wvjkqazbrsf3hg@wittgenstein>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <87pn71gxi8.fsf@mid.deneb.enyo.de>
 <5447a405-4e4f-8034-eb86-ec2f6ddf45f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5447a405-4e4f-8034-eb86-ec2f6ddf45f0@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Paolo,

On Fri, Sep 04, 2020 at 10:18:17PM +0200, Paolo Bonzini wrote:
> On 04/09/20 21:19, Florian Weimer wrote:
> > I'm not sure what the advantage is of returning separate file
> > descriptors, and nit operating directly on the pidfd.
> 
> For privilege separation.  So far, the common case of pidfd operations
> has been that whoever possesses a pidfd has "power" over the target

I may misunderstand you but that's actually not quite true. Currently,
pidfds are just handles on processes and currently only convey identity.
They don't guarantee any sort of privilege over the target process. We
have had discussion to treat them more as a capability in the future but
that needs to be carefully thought out.

> process.  Here however we also want to cover the case where one
> privileged process wants to set up and manage a memory range for
> multiple children.  The privilege process can do so by passing the
> access file descriptor via SCM_RIGHTS.
> 
> We also want different children to have visibility over different
> ranges, which is why there are multiple control fds rather than using
> the pidfd itself as control fd.  You could have the map/unmap/lock ioctl
> on the pidfd itself and the access fd as an argument of the ioctl, but
> it seems cleaner to represent the pidfd-mem control capability as its
> own file descriptor.

We have very much on purpose avoided adding ioctls() on top of pidfds
and I'm not fond of the idea of starting to add them. Supporting
ioctl()s on an fd usually opens up a can of worms and makes sneaking in
questionable features more likely (I'm not saying your patchset does
that!).
If this interface holds up, I would ask you to please either keep this
as a separate fd type or please propose system calls only.

Christian
