Return-Path: <linux-api+bounces-195-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504497FFBAF
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D12824F2
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658752F91;
	Thu, 30 Nov 2023 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ysx3+T/m"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BCCD7D
	for <linux-api@vger.kernel.org>; Thu, 30 Nov 2023 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701373403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LzR82TZZoRBH/QGAZ8DY5Aa+itdrUDM4gzCDXUwKhE=;
	b=Ysx3+T/mVS7pVHYhsAKoKYAU0y5Ntu1UafkmpBaQWyhyuJvIvdyph86BBZGhosznfS6fkH
	dGCe/fP0FDfPh5ZAzumfDlXiALW3kpUje4IPTsmGQVh4cP4/Y2SRnvhKQOOPL/sCvtAiHD
	wmZjFPB+Qm3QsTCLuha101Llh/d0QiM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-HioBAyClOBG-ZY4j2hqARw-1; Thu,
 30 Nov 2023 14:43:22 -0500
X-MC-Unique: HioBAyClOBG-ZY4j2hqARw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB73B381CBA1;
	Thu, 30 Nov 2023 19:43:21 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 046491121307;
	Thu, 30 Nov 2023 19:43:19 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tycho Andersen <tycho@tycho.pizza>,  Christian Brauner
 <brauner@kernel.org>,  Oleg Nesterov <oleg@redhat.com>,  "Eric W .
 Biederman" <ebiederm@xmission.com>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
References: <20231130163946.277502-1-tycho@tycho.pizza>
	<874jh3t7e9.fsf@oldenburg.str.redhat.com>
	<ZWjaSAhG9KI2i9NK@tycho.pizza>
	<a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
Date: Thu, 30 Nov 2023 20:43:18 +0100
In-Reply-To: <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com> (Mathieu
	Desnoyers's message of "Thu, 30 Nov 2023 14:00:01 -0500")
Message-ID: <87ttp3rprd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

* Mathieu Desnoyers:

>>> I'd like to offer a userspace API which allows safe stashing of
>>> unreachable file descriptors on a service thread.

>> By "safe" here do you mean not accessible via pidfd_getfd()?

No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
intra-process transfer using /proc, but I'm hoping for something nicer.

Thanks,
Florian


