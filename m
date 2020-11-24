Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22C2C2905
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 15:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgKXOIY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 09:08:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbgKXOIX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 09:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606226901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXy3ecs+HX3+K1WnKeyew4ESrbgIT3k+SY8QKhWbc6I=;
        b=Sjp9KJ8joYAbH//0ABNtR4BMArxTHRbD/0y8yhHZsX20WW/q1n81GmZiC4HPfKKtfD7E53
        2P80qWGuUN/9w3WtndhhnCuG90qPpE7aZpNupSe2onuCgwQEEnMKqsXy+Zah8nKa8IDm0i
        NkxJOJ19AJMTyyJ03g6Wmfr+gQI+5gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-HGYUlOEvNEKCDrCaB02O6Q-1; Tue, 24 Nov 2020 09:08:17 -0500
X-MC-Unique: HGYUlOEvNEKCDrCaB02O6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E3D1107ACFE;
        Tue, 24 Nov 2020 14:08:16 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 741335D71B;
        Tue, 24 Nov 2020 14:08:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
        <20201124133719.GA30896@infradead.org>
Date:   Tue, 24 Nov 2020 15:08:09 +0100
In-Reply-To: <20201124133719.GA30896@infradead.org> (Christoph Hellwig's
        message of "Tue, 24 Nov 2020 13:37:19 +0000")
Message-ID: <87k0ua26gm.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christoph Hellwig:

> On Tue, Nov 24, 2020 at 01:08:20PM +0100, Florian Weimer wrote:
>> This documents a way to safely use new security-related system calls
>> while preserving compatibility with container runtimes that require
>> insecure emulation (because they filter the system call by default).
>> Admittedly, it is somewhat hackish, but it can be implemented by
>> userspace today, for existing system calls such as faccessat2,
>> without kernel or container runtime changes.
>
> I think this is completely insane.  Tell the OCI folks to fix their
> completely broken specification instead.

Do you categorically reject the general advice, or specific instances as
well?  Like this workaround for faccessat that follows the pattern I
outlined:

<https://sourceware.org/pipermail/libc-alpha/2020-November/119955.html>

I value your feedback and want to make sure I capture it accurately.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

