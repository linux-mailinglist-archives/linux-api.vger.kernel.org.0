Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756C8EB53D
	for <lists+linux-api@lfdr.de>; Thu, 31 Oct 2019 17:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfJaQrD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 31 Oct 2019 12:47:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728913AbfJaQrD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 31 Oct 2019 12:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572540421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IN5IfNgFP34DHGSztrtam2F8ra3NciZQQBpcLS3E0ho=;
        b=iXE3SWt6m+CUaAvLI3fMl7DUAxoqVIVM4pQyzq4Rt32uCteY5HrOfTH1ZhqgyaPqxf+WE8
        Y4CO9+Tk+Lk9d44mUXTICmyXYwPpyLQsM+Q90Sz7ww4UKvEsPlrh8C6jpmgbbFxMd0A5V6
        EsG3/YitZtO19MsVpHbqh6hfO8yZqnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-v6RguP_-OjCguHYJtNow1g-1; Thu, 31 Oct 2019 12:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4ABB1800D55;
        Thu, 31 Oct 2019 16:46:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6B1AC60852;
        Thu, 31 Oct 2019 16:46:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 31 Oct 2019 17:46:56 +0100 (CET)
Date:   Thu, 31 Oct 2019 17:46:53 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clone3: validate stack arguments
Message-ID: <20191031164653.GA24629@redhat.com>
References: <20191031113608.20713-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
In-Reply-To: <20191031113608.20713-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: v6RguP_-OjCguHYJtNow1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/31, Christian Brauner wrote:
>
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -51,6 +51,10 @@
>   *               sent when the child exits.
>   * @stack:       Specify the location of the stack for the
>   *               child process.
> + *               Note, @stack is expected to point to the
> + *               lowest address. The stack direction will be
> + *               determined by the kernel and set up
> + *               appropriately based on @stack_size.

I can't review this patch, I have no idea what does stack_size mean
if !arch/x86.

x86 doesn't use stack_size unless a kthread does kernel_thread(), so
this change is probably fine...

Hmm. Off-topic question, why did 7f192e3cd3 ("fork: add clone3") add
"& ~CSIGNAL" in kernel_thread() ? This looks pointless and confusing
to me...

> +static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
> +{
> +=09if (kargs->stack =3D=3D 0) {
> +=09=09if (kargs->stack_size > 0)
> +=09=09=09return false;
> +=09} else {
> +=09=09if (kargs->stack_size =3D=3D 0)
> +=09=09=09return false;

So to implement clone3_wrapper(void *bottom_of_stack) you need to do

=09clone3_wrapper(void *bottom_of_stack)
=09{
=09=09struct clone_args args =3D {
=09=09=09...
=09=09=09// make clone3_stack_valid() happy
=09=09=09.stack =3D bottom_of_stack - 1,
=09=09=09.stack_size =3D 1,
=09=09};
=09}

looks a bit strange. OK, I agree, this example is very artificial.
But why do you think clone3() should nack stack_size =3D=3D 0 ?

> +=09=09if (!access_ok((void __user *)kargs->stack, kargs->stack_size))
> +=09=09=09return false;

Why?

Oleg.

