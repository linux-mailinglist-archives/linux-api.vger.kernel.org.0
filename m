Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB923147ABC
	for <lists+linux-api@lfdr.de>; Fri, 24 Jan 2020 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgAXJhb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jan 2020 04:37:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726080AbgAXJhb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jan 2020 04:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579858650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QugXP++tX2QdF2BlYh+oWt5d/1+WjAi+1riPy4DfzEI=;
        b=XsaJ/DyUjXSvnPyZs3/fZtppGSEM7b3lT1cvKYUIru3cDpcrzpDnXAfiojLTe1YBJTRI07
        z7ntmACyGv+TPErmjIatZyXyydTJlWOlkZPfIbNfirtljKqU8vr29eAcwuN7SoeD3tovWQ
        nt4HQjhGQoj8WByAKenbu8yMYJAZkg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-5EmjIe8IMX62BrAeobcsDg-1; Fri, 24 Jan 2020 04:37:26 -0500
X-MC-Unique: 5EmjIe8IMX62BrAeobcsDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F306DB23;
        Fri, 24 Jan 2020 09:37:25 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-227.str.redhat.com [10.33.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 253A210016EB;
        Fri, 24 Jan 2020 09:37:23 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Proposal to fix pwrite with O_APPEND via pwritev2 flag
References: <20200124000243.GA12112@brightrain.aerifal.cx>
Date:   Fri, 24 Jan 2020 10:37:22 +0100
In-Reply-To: <20200124000243.GA12112@brightrain.aerifal.cx> (Rich Felker's
        message of "Thu, 23 Jan 2020 19:02:43 -0500")
Message-ID: <87d0b942lp.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Rich Felker:

> There's a longstanding unfixable (due to API stability) bug in the
> pwrite syscall:
>
> http://man7.org/linux/man-pages/man2/pwrite.2.html#BUGS
>
> whereby it wrongly honors O_APPEND if set, ignoring the caller-passed
> offset. Now that there's a pwritev2 syscall that takes a flags
> argument, it's possible to fix this without breaking stability by
> adding a new RWF_NOAPPEND flag, which callers that want the fixed
> behavior can then pass.
>
> I have a completely untested patch to add such a flag, but would like
> to get a feel for whether the concept is acceptable before putting
> time into testing it. If so, I'll submit this as a proper patch with
> detailed commit message etc. Draft is below.

Has this come up before?

I had already written a test case and it turns out that an O_APPEND
descriptor does not protect the previously written data in the file:

openat(AT_FDCWD, "/tmp/append-truncateuoRexJ", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
write(3, "@", 1)                        = 1
close(3)                                = 0
openat(AT_FDCWD, "/tmp/append-truncateuoRexJ", O_WRONLY|O_APPEND) = 3
ftruncate(3, 0)                         = 0

So at least it looks like there is no security issue in adding a
RWF_NOAPPEND flag.

Thanks,
Florian

