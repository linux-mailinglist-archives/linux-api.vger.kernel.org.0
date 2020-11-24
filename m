Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF692C2F7D
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 19:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbgKXSDJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 13:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403997AbgKXSDJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 13:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606240987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQRdCyEjd8lB1hJnU6FBbehjJrMGCDIdPwywH5xUhec=;
        b=F3cHrruKqokAUNYMyINP8ywhDlYxdjZSGEK6bqix/Lkth1CVIoByODRo17H0EZB24UgieP
        N5LCsvSlUs6NAhejkRQDyG6X+tB2KTEgHGZJpGAiAKIQmfTCy4aVtGGyhV41+8p5oSQwJO
        ox0GayFsHQhi0k/dngXHfi6mECjmPRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-IEMlTEUgMoO_v_UEUqZUmA-1; Tue, 24 Nov 2020 13:03:03 -0500
X-MC-Unique: IEMlTEUgMoO_v_UEUqZUmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5802A18C43C7;
        Tue, 24 Nov 2020 18:03:01 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 770F75D6AB;
        Tue, 24 Nov 2020 18:02:55 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Mark Wielaard <mark@klomp.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        dev@opencontainers.org, Jonathan Corbet <corbet@lwn.net>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
        <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
        <878saq3ofx.fsf@oldenburg2.str.redhat.com>
        <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
        <20201124164546.GA14094@infradead.org>
        <CAG48ez2ZHPavVU3_2VnRADFQstOM1s+3GwfWsRaEjAA1jYcHDg@mail.gmail.com>
Date:   Tue, 24 Nov 2020 19:02:53 +0100
In-Reply-To: <CAG48ez2ZHPavVU3_2VnRADFQstOM1s+3GwfWsRaEjAA1jYcHDg@mail.gmail.com>
        (Jann Horn's message of "Tue, 24 Nov 2020 18:06:38 +0100")
Message-ID: <87pn42zl82.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Jann Horn:

> +seccomp maintainers/reviewers
> [thread context is at
> https://lore.kernel.org/linux-api/87lfer2c0b.fsf@oldenburg2.str.redhat.com/
> ]
>
> On Tue, Nov 24, 2020 at 5:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>> On Tue, Nov 24, 2020 at 03:08:05PM +0100, Mark Wielaard wrote:
>> > For valgrind the issue is statx which we try to use before falling back
>> > to stat64, fstatat or stat (depending on architecture, not all define
>> > all of these). The problem with these fallbacks is that under some
>> > containers (libseccomp versions) they might return EPERM instead of
>> > ENOSYS. This causes really obscure errors that are really hard to
>> > diagnose.
>>
>> So find a way to detect these completely broken container run times
>> and refuse to run under them at all.  After all they've decided to
>> deliberately break the syscall ABI.  (and yes, we gave the the rope
>> to do that with seccomp :().
>
> FWIW, if the consensus is that seccomp filters that return -EPERM by
> default are categorically wrong, I think it should be fairly easy to
> add a check to the seccomp core that detects whether the installed
> filter returns EPERM for some fixed unused syscall number and, if so,
> prints a warning to dmesg or something along those lines...

But that's playing Core Wars, right?  Someone will write a seccomp
filter trying to game that kernel check.  I don't really think it solves
anything until there is consensus what a system call filter should do
with system calls not on the permitted list.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

