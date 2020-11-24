Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB83C2C26C3
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbgKXNGG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 08:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732763AbgKXNGG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 08:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606223165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4KDtrnaWEASZaV9k/ZyN6/dmLtE0hhZRztvsR1lW+Q=;
        b=guJIKqXyMEz32Mbs4Eh1JWGNp2EfwqnzekGo+lgouuNnmCI714Ob8RTIzZF6IsN7oXROlU
        8hY3ZMme1gMpVHENwlH1L93prdFBshEAWHNq8su4ylUymj2TDKrQB0quRLLMozC6TfyeTO
        5BsHuLcYhQeI+UWQbCronlmXxGZo4Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-KSMP2231N5yn3YeQwoFfrg-1; Tue, 24 Nov 2020 08:06:02 -0500
X-MC-Unique: KSMP2231N5yn3YeQwoFfrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3DFD1922020;
        Tue, 24 Nov 2020 13:06:00 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E0765C1BD;
        Tue, 24 Nov 2020 13:05:55 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
        <20201124125806.nud2x5kfvnxdagqk@yavin.dot.cyphar.com>
Date:   Tue, 24 Nov 2020 14:05:54 +0100
In-Reply-To: <20201124125806.nud2x5kfvnxdagqk@yavin.dot.cyphar.com> (Aleksa
        Sarai's message of "Tue, 24 Nov 2020 23:58:06 +1100")
Message-ID: <874kle3nwt.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Aleksa Sarai:

> As I mentioned in the runc thread[1], this is really down to Docker's
> default policy configuration. The EPERM-everything behaviour in OCI was
> inherited from Docker, and it boils down to not having an additional
> seccomp rule which does ENOSYS for unknown syscall numbers (Docker can
> just add the rule without modifying the OCI runtime-spec -- so it's
> something Docker can fix entirely on their own). I'll prepare a patch
> for Docker this week.

Appreciated, thanks.

> IMHO it's also slightly overkill to change the kernel API design
> guidelines in response to this issue.
>
> [1]: https://github.com/opencontainers/runc/issues/2151

Won't this cause docker to lose OCI compliance?  Or is the compliance
testing not that good?

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

