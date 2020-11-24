Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACA2C2698
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 13:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbgKXMyl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 07:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733265AbgKXMyk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 07:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606222479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NxyDVGiScUymMEgZnP7ajOPo8IogUNPzYRx+wwBnAqs=;
        b=SbDvw9Vnlm5TuaFN7VBPy2bSNVDxpYQTolbKIXEBA+DYlD4gUDXqBit4Id4SUiZQOdRkAB
        d+c3vmWA1pLJvr9dG7a5/fbsp2ysG7zvNfve3ng6r/SyDHvIXVfPRFwf2lUW/3DQTdnxpH
        OCC2akqA8bg55Sb2b+6+HuhFlgwf/Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-vV42pFFiPLGyIrUVbaVWiQ-1; Tue, 24 Nov 2020 07:54:34 -0500
X-MC-Unique: vV42pFFiPLGyIrUVbaVWiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4561010151E9;
        Tue, 24 Nov 2020 12:54:33 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C3D45D9CA;
        Tue, 24 Nov 2020 12:54:28 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
        <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
Date:   Tue, 24 Nov 2020 13:54:26 +0100
In-Reply-To: <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein> (Christian
        Brauner's message of "Tue, 24 Nov 2020 13:26:39 +0100")
Message-ID: <878saq3ofx.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christian Brauner:

> I'm sorry but I have some doubts about this new "rule". The idea of
> being able to reliably trigger an error for a system call other then
> EPERM might have merrit in some scenarios but justifying it via a bug in
> a userspace standard is not enough in my opinion.
>
> The solution is to fix the standard to mandate ENOSYS. This is the
> correct error for this exact scenario and standards can be changed.
> I don't think it is the kernel's job to work around a deliberate
> userspace decision to use EPERM and not ENOSYS. The kernel's system call
> design should not be informed by this especially since this is clearly
> not a kernel bug.
>
> Apart from that I have doubts that this is in any shape or form
> enforceable. Not just because in principle there might be system calls
> that only return EPERM on error but also because this requirement feels
> arbitrary and I doubt developers will feel bound by it or people will
> check for it.
>
>> +
>> +If a system call has such error behavior, upon encountering an
>> +``EPERM`` error, userspace applications can perform further
>> +invocations of the same system call to check if the ``EPERM`` error
>> +persists for those known error conditions.  If those also fail with
>> +``EPERM``, that likely means that the original ``EPERM`` error was the
>> +result of a seccomp filter, and should be treated like ``ENOSYS``
>
> I think that this "approach" alone should illustrate that this is the
> wrong way to approach this. It's hacky and requires excercising a system
> call multiple times just to find out whether or not it is supported.
> The only application that would possibly do this is probably glibc.
> This seems to be the complete wrong way of solving this problem.

Thank you for your feedback.  I appreciate it.

I agree that the standard should mandate ENOSYS, and I've just proposed
a specification change here:

  <https://groups.google.com/a/opencontainers.org/g/dev/c/8Phfq3VBxtw>

However, such a change may take some time to implement.

Meanwhile, we have the problem today with glibc that it wants to use the
faccessat2 system call but it can't.  I've been told that it would make
glibc incompatible with the public cloud and Docker.  The best solution
I could come up with it is this awkward probing sequence.  (Just
checking for the zero flags argument is not sufficient because systemd
calls fchmodat with AT_SYMLINK_NOFOLLOW.)

I do not wish to put the probing sequence into glibc (upstream or
downstream) unless it is blessed to some degree by kernel developers.  I
consider it quite ugly and would prefer if more of us share the blame.

We will face the same issue again with fchmodat2 (or fchmodat4 if that's
what it's name is going to be).  And we have been lucky in recent times
that didn't need a new system call to fix a security vulnerability in an
existing system call in wide use by userspace (although faccessat2 comes
rather close because it replaces a userspace permission check
approximation with a proper kernel check).  The seccomp situation means
that we can't, reliably, and the probing hack seems to be way out.
That's another reason for not just putting in the probing sequence
quietly and be done with it: I'd like to discuss this aspect in the
open, before we need it as part of a fix for some embargoed security
vulnerability.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

