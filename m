Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D328124621
	for <lists+linux-api@lfdr.de>; Wed, 18 Dec 2019 12:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfLRLvg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Dec 2019 06:51:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbfLRLvg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Dec 2019 06:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576669895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+3DyTzXgGOGS5B/c0k6Rz478MMox0LVeNSfsn2KZ78=;
        b=B5rlhCC/KLSZxsx67378sqJ4JgQ6uDHmnrmvobhg1bK369tZuD150CD1QPflmTRYJnHulZ
        FLAxCxTn/c31/SpbW+zfF3MWjWb/FjddZ6zObKizkzHqp8QElbeSFBTh+R/T7xn2zauaiE
        qUPswrAlDsXTF3k6RTLiFKOX99CVM9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-Iv6odr2hPpa-ePJD_HkXBQ-1; Wed, 18 Dec 2019 06:51:32 -0500
X-MC-Unique: Iv6odr2hPpa-ePJD_HkXBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 009F3DB20;
        Wed, 18 Dec 2019 11:51:31 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-248.ams2.redhat.com [10.36.116.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19E585C28D;
        Wed, 18 Dec 2019 11:51:28 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        Quentin Bouget <quentin.bouget@cea.fr>,
        Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: statx struct's stx_size pointer compatibility with uint64_t/size_t
References: <87r213aykv.fsf@oldenburg2.str.redhat.com>
        <20191217152154.GB25518@nautica> <20191217165350.GA10729@nautica>
Date:   Wed, 18 Dec 2019 12:51:26 +0100
In-Reply-To: <20191217165350.GA10729@nautica> (Dominique Martinet's message of
        "Tue, 17 Dec 2019 17:53:50 +0100")
Message-ID: <87mubp26o1.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Dominique Martinet:

> This makes sense to me to avoid multiplying header files for the
> different arches, so if anything I would be tempted to ask 'why is
> stdint.h uint64_t defined with just long'?

It's not a compiler-provided header.  When it was added to glibc in the
90s, I don't think long long support was universal among 64-bit
compilers, and you could not just drop the type (which might have been
acceptable on 32-bit architectures).

Anyway, looking at this, it looks like we should define struct statx
with unsigned long long int in our copy instead of uint64_t.  I filed
bug 25292 to track this.  I guess it's just another thing to keep in
mind when adding system call support to glibc headers.

Thanks,
Florian

