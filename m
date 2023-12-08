Return-Path: <linux-api+bounces-304-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D980AC21
	for <lists+linux-api@lfdr.de>; Fri,  8 Dec 2023 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5318D2819CD
	for <lists+linux-api@lfdr.de>; Fri,  8 Dec 2023 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF933090;
	Fri,  8 Dec 2023 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UX2MzQNw"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D47121
	for <linux-api@vger.kernel.org>; Fri,  8 Dec 2023 10:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702060530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4wJSXXt5neot2flp1x6zxgWM58LefvpkGHJupVSw+E=;
	b=UX2MzQNwrlZvTRi17WOxoOVopgJzhkwq5cA/RKg6go9m6gAv643VPHC44qj+QCvLlvLDYW
	VmOPNAWKYuZjuob5Z+EDmvrytcGiNurRdCdrrcVkxb3UHBazOtlvq5QjdNlS5u7/zdtBjS
	Bw9W+jpDnbGVTZlZeKXRVUOE4UCUkus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-gmoEQhd6N3KHZ7niw_I7xw-1; Fri, 08 Dec 2023 13:35:29 -0500
X-MC-Unique: gmoEQhd6N3KHZ7niw_I7xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B577A845DC1;
	Fri,  8 Dec 2023 18:35:28 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38C3C3C2E;
	Fri,  8 Dec 2023 18:35:27 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-api@vger.kernel.org,  x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
	<87v89dvuxg.fsf@oldenburg.str.redhat.com>
	<1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
	<202312061236.DE847C52AA@keescook>
	<4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
	<202312081027.BA44B7B3@keescook>
Date: Fri, 08 Dec 2023 19:35:25 +0100
In-Reply-To: <202312081027.BA44B7B3@keescook> (Kees Cook's message of "Fri, 8
	Dec 2023 10:29:25 -0800")
Message-ID: <87lea4czki.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

* Kees Cook:

> I significantly prefer APIs not being arch-specific, so I'd prefer we
> always include AT_PAGE_SHIFT_MASK. For an architecture that doesn't
> define its own ARCH_AT_PAGE_SHIFT_MASK, it's not _inaccurate_ to report
> 1 << PAGE_SHIFT, but it might be incomplete.

The downside is that as an application programmer, I have to go and
chase for the information the legacy way if I encounter
getauxval(AT_PAGE_SHIFT_MASK) == getpagesize() for a longer time
because the interface does not signal the absence of any extended
page sizes.

Thanks,
Florian


