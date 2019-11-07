Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4926FF2DF3
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 13:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKGMLA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 07:11:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40191 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726873AbfKGMLA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 07:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573128659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkIQqir5pW7f0G3vmE6jkltpSFD4oviKVpNlhFvzoLk=;
        b=hZOiWab1KBez1ZCM7+ySFlxVt2W+lS6I5ZmQxyE5HUSZO+LQIkxhWSYqIgFUMHhbTxlx0a
        PBiialI1gJc2FGiat+36wo0Idq6Es+yYzs7fy2qvk6/oecknO48eqzLUlE4GtO76ncZCRt
        wpRifo1xr0cxi/YzTit/NBJ51lCHkTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-wbKC7P3UNW6IlyI5MKNOJQ-1; Thu, 07 Nov 2019 07:10:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85E071005500;
        Thu,  7 Nov 2019 12:10:55 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F21019C6A;
        Thu,  7 Nov 2019 12:10:54 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Elichai Turkel <elichai.turkel@gmail.com>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Continuing the UAPI split
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
        <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
Date:   Thu, 07 Nov 2019 13:10:53 +0100
In-Reply-To: <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com> (Christian
        Brauner's message of "Thu, 07 Nov 2019 13:05:16 +0100")
Message-ID: <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wbKC7P3UNW6IlyI5MKNOJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christian Brauner:

> [+Cc Florian, glibc]
>
> On November 7, 2019 12:17:50 PM GMT+01:00, Elichai Turkel <elichai.turkel=
@gmail.com> wrote:
>>Hi,
>>I'm working on a library that calls syscalls directly to the kernel.
>>`make hedears_install` is a great command to auto generate the UAPI
>>headers that are needed to call the kernel.
>>
>>But the headers are still missing a bunch of defines for flags and
>>structs.
>>
>>I wanted to know if patches to move more things from `./include/linux`
>>to `./include/uapi/linux` are welcome (obviously only
>>typedefs/defines/structs that are required for the syscalls)
>>
>>I think the UAPI is really close to getting a complete set of things
>>needed to communicate with the syscalls, but still not quite there. I
>>would like to push patches whenever I see missing things that my
>>library needs (that way it will be incrementally and by usage only).

The kernel uses some POSIX names with POSIX-incompatible definitions,
e.g. struct msghdr.  Some libcs prioritize POSIX conformance over kernel
conformance and implement userspace translation for mismatch types.
When building against such libcs, it becomes difficult to use UAPI and
libc headers in a single translation unit.  (It is already difficult
today in some cases.)

I don't know a good solution here.  Not using POSIX names in UAPI
headers is one option.  Previously, we have tried to use preprocessor
macros to coordinate definitions, but did not work well in practice
(only few conflicts were ever resolved).  It does not help at all when
the definitions are incompatible.

Thanks,
Florian

