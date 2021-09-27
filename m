Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD5419EA4
	for <lists+linux-api@lfdr.de>; Mon, 27 Sep 2021 20:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhI0SxE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Sep 2021 14:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235830AbhI0SxC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Sep 2021 14:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632768683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9qKCi3TeSZ7u8iFrrHJUmuKpIjXTK7k9xJIvqBA+sw=;
        b=KA0OIO2Wb4uTNUHD6xRBAJ9y/jdQ8VFdLUB5pNJ7N1Fuu/Vj2tY73YFqF0DMGLR9RimDQK
        oUNoflEkkz5DEz0IoXe0QsSMNroKf5QbLGuw5beNkheVXy2vm4iLnFrrpyA/CU7SOrYBsS
        AQysPPw3sTfMNm/ynkmLY6dsUvUQtjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-_SCqgygdN2KWbwHATyj3fA-1; Mon, 27 Sep 2021 14:51:20 -0400
X-MC-Unique: _SCqgygdN2KWbwHATyj3fA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86BBC1084681;
        Mon, 27 Sep 2021 18:51:17 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E2D85D9D3;
        Mon, 27 Sep 2021 18:51:12 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     x86@kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rpalethorpe@richiejp.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        ltp@lists.linux.it
Subject: Re: [PATCH] x86/entry/ia32: Ensure s32 is sign extended to s64
References: <20210927161955.28494-1-rpalethorpe@suse.com>
Date:   Mon, 27 Sep 2021 20:51:11 +0200
In-Reply-To: <20210927161955.28494-1-rpalethorpe@suse.com> (Richard
        Palethorpe's message of "Mon, 27 Sep 2021 17:19:55 +0100")
Message-ID: <875yuletsw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Richard Palethorpe:

> +#define __SC_COMPAT_CAST(t, a)						\
> +	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
> +	(unsigned int)a

So this casts to int (triggering sign extension) if the type on the
64-bit kernel side is long?  But not in other cases (unsigned long,
pointer)?  Just double-checking.

Thanks,
Florian

