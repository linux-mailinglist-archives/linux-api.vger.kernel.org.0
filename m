Return-Path: <linux-api+bounces-190-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E37FF984
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B642816EE
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3910E524D1;
	Thu, 30 Nov 2023 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRWfEstT"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B7010D0
	for <linux-api@vger.kernel.org>; Thu, 30 Nov 2023 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701369434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPXCfmMAxbqQxyMucaabmjeI2zK+WyVJ0GgG5IsxqJU=;
	b=VRWfEstTs6pl8p8latr98O3hb1cu+D+w1wj70gKG1oeCofsRukkDiUNNRokgQgyjKGMhcg
	cbQFPwKzvQJ3aWahGnn759nyOhQLkTFm5+2crmgIJcY1Pta9Kcl+7l59VAKRvFxhRo4bgJ
	ZNKxPfhodUx8wy0pulllJQHbUlinE5M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-8Q7ESA0UNTaYG9qmgH8r8Q-1; Thu, 30 Nov 2023 13:37:07 -0500
X-MC-Unique: 8Q7ESA0UNTaYG9qmgH8r8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33AD7101A52D;
	Thu, 30 Nov 2023 18:37:06 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 769A11C060B1;
	Thu, 30 Nov 2023 18:37:04 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,  Oleg Nesterov
 <oleg@redhat.com>,  "Eric W . Biederman" <ebiederm@xmission.com>,
  linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,  Tycho Andersen
 <tandersen@netflix.com>, mathieu.desnoyers@efficios.com
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
References: <20231130163946.277502-1-tycho@tycho.pizza>
Date: Thu, 30 Nov 2023 19:37:02 +0100
In-Reply-To: <20231130163946.277502-1-tycho@tycho.pizza> (Tycho Andersen's
	message of "Thu, 30 Nov 2023 09:39:44 -0700")
Message-ID: <874jh3t7e9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

* Tycho Andersen:

> From: Tycho Andersen <tandersen@netflix.com>
>
> We are using the pidfd family of syscalls with the seccomp userspace
> notifier. When some thread triggers a seccomp notification, we want to do
> some things to its context (munge fd tables via pidfd_getfd(), maybe write
> to its memory, etc.). However, threads created with ~CLONE_FILES or
> ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
> purpose, since their fd table or mm are distinct from the thread group
> leader's. In this patch, we relax this restriction for pidfd_open().

Does this mean that pidfd_getfd cannot currently be used to get
descriptors for a TID if that TID doesn't happen to share its descriptor
set with the thread group leader?

I'd like to offer a userspace API which allows safe stashing of
unreachable file descriptors on a service thread.

Cc:ing Mathieu because of our previous discussions?

Thanks,
Florian


