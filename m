Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0145DF2F20
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 14:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfKGNXe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 08:23:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44965 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730980AbfKGNXe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 08:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx7MNsrxcRGx1utwe0Nx81UEhha0KBf3YZmV48uH1qo=;
        b=KtRtT5zDvrxqI8fmmuLxQB4gI/3o3rdkDvG/54xz2vHQiX4YeX8o88BGw36FgVtqnF7f22
        DlsBeFjecsmMEeTf3M1SC0g0Zk+EbawPMhPJLfgZ1GBkEU0RUYn+JArP3GOWafFVEvrGDk
        FOqEQ0i7tAOk/e/S8Cluf+Fx3XNUt2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-itvFXv0iPICVtZE-2gYPWg-1; Thu, 07 Nov 2019 08:23:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD7C8477;
        Thu,  7 Nov 2019 13:23:28 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0C2719C6A;
        Thu,  7 Nov 2019 13:23:27 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Elichai Turkel <elichai.turkel@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Continuing the UAPI split
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
        <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
        <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
        <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
Date:   Thu, 07 Nov 2019 14:23:26 +0100
In-Reply-To: <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
        (Elichai Turkel's message of "Thu, 7 Nov 2019 15:03:12 +0200")
Message-ID: <87zhh7hlbl.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: itvFXv0iPICVtZE-2gYPWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Elichai Turkel:

> Thanks for the response,
> I'm not sure what are you suggesting exactly.
> A rename to the structs/types so they won't collide with libc?

Or use namespaces.  I mean, we have had proper technical solutions for
this issue for more than 20 years now.  I know that this isn't going to
happen, though.

> Prioritizing POSIX conformance in the kernel(I think that ship has long s=
ailed)?

That doesn't really work anyway if userspace has different versions of
the type depending on feature macros.  Examples are struct stat or soon
struct timespec on 32-bit architectures.

> Or just giving up and telling users they can't just directly include
> both libc headers and kernel headers?

That's what I've been telling users if they encounter fringe cases I
can't fix on the glibc side.

It might also help if top-level types for end user use would be in
separate headers.  This is what we started doing internally in glibc, to
disentangle our own headers and eliminate cyclic dependencies.

> (I'm actually not sure how it works now. because there are definitely
> collision and if we are using ifdefs and undefs black magic you still
> end up with a single declaration in the end that might not be
> compatible with both libc and kernel)

Officially, it's supposed to work today.  We have one glibc developer
who says that it's easy to solve, but I disagree strongly.  The fact
that the problems are not fixed promptly suggests that it's anything but
simple.

What I've been doing instead is to include UAPI headers directly from
glibc headers if it's technically feasible.  (It's not possible in POSIX
mode, where we have to manage the set of exported symbols closely, or
generally with old compilers which do not have __has_include.)  See
<bits/statx.h>, <bits/statx-generic.h> etc. in current glibc for an
example.

If you add more type definitions to kernel headers, this might interfere
with such usage of UAPI headers because today, we need to provide our
own definitions for many things not in UAPI headers, and the currently
deployed glibc headers are simply not compatible with such future
changes.

Thanks,
Florian

