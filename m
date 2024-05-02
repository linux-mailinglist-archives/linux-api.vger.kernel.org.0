Return-Path: <linux-api+bounces-1441-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B88B9920
	for <lists+linux-api@lfdr.de>; Thu,  2 May 2024 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F15A1C20A79
	for <lists+linux-api@lfdr.de>; Thu,  2 May 2024 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4855FBB7;
	Thu,  2 May 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcwlZvIf"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1415A0F8
	for <linux-api@vger.kernel.org>; Thu,  2 May 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646389; cv=none; b=sDz1jjGlNHOfR0LNvcI0H7QcJuquR/C0FVYECdRCDOzL3ZOZ0cM+I8Upw/TFnkisALaboIJHIcyI7AifAea0s0CcfM2ywTXwxuV2Ur+moDGUzE3B/9Lvo3lYZsT75/Wh+7qf7f4u6YYRWmfPo/sm3691de1vsoBfezPimY5so1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646389; c=relaxed/simple;
	bh=s6FKwE54UFYNcw1jeMV5GJo5kZugtlV25ulBqGrd9nE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y0m8uoLpoTDqv6x5uvuKoiArptb8xqesk0enGx0ZDC8PQlYFgb0txrajiJZ5vBfQ3O2OOTp63SMx/rviY64ALsOE4l2qK7pYLSF+bS8BLjKUnX2qRnfZ2DtPkrOrvfO5/Dcc+5BZX+TLhQLzRwfiiGjnFUsNjuvczylF6byunRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcwlZvIf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714646386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORypNU4Jg7o5BAaBkjAQJMzFWJt5/boPJ1mc2TGpTGY=;
	b=EcwlZvIfcnkrB3z4dSrRzS3UXKMWKstr/ip2JowcOuqg608JTMywKvheFrIocE59pQz288
	Rr5dih2Jth6U8sbHWxv0UO0je3VB2QqU7Uq5bp5HrcnwjExEeDPohlDRAAcXlKrXg7a5GQ
	bL/WF2FU67lSaUiEb+AFTUSd0Yo1fwk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-Wr_bK_1HPduzif-IY4Kl-w-1; Thu,
 02 May 2024 06:39:42 -0400
X-MC-Unique: Wr_bK_1HPduzif-IY4Kl-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C0363820EA9;
	Thu,  2 May 2024 10:39:41 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.188])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C1D6AC13FA6;
	Thu,  2 May 2024 10:39:35 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Mathieu
 Desnoyers
 <mathieu.desnoyers@efficios.com>,  Peter Zijlstra <peterz@infradead.org>,
  Thomas Gleixner <tglx@linutronix.de>,  linux-kernel@vger.kernel.org,
  "Paul E . McKenney" <paulmck@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  "H . Peter Anvin" <hpa@zytor.com>,  Paul Turner
 <pjt@google.com>,  linux-api@vger.kernel.org,  David.Laight@aculab.com,
  carlos@redhat.com,  Peter Oskolkov <posk@posk.io>,  Alexander Mikhalitsyn
 <alexander@mihalicyn.com>,  Chris Kennelly <ckennelly@google.com>,  Ingo
 Molnar <mingo@redhat.com>,  Darren Hart <dvhart@infradead.org>,  Davidlohr
 Bueso <dave@stgolabs.net>,  libc-alpha@sourceware.org,  Steven Rostedt
 <rostedt@goodmis.org>,  Jonathan Corbet <corbet@lwn.net>,  Noah Goldstein
 <goldstein.w.n@gmail.com>,  Daniel Colascione <dancol@google.com>,
  longman@redhat.com,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
In-Reply-To: <20240502-sporen-pirschen-039688cd9efe@brauner> (Christian
	Brauner's message of "Thu, 2 May 2024 12:14:11 +0200")
References: <20240425204332.221162-1-andrealmeid@igalia.com>
	<20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
	<f052ff72-72c9-4b83-9285-2cd9d52e5f72@igalia.com>
	<20240502-gezeichnet-besonderen-d277879cd669@brauner>
	<8734r0o81v.fsf@oldenburg.str.redhat.com>
	<20240502-sporen-pirschen-039688cd9efe@brauner>
Date: Thu, 02 May 2024 12:39:34 +0200
Message-ID: <871q6kmra1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

* Christian Brauner:

>> From a glibc perspective, we typically cannot use long-term file
>> descriptors (that are kept open across function calls) because some
>> applications do not expect them, or even close them behind our back.
>
> Yeah, good point. Note, I suggested it as an extension not as a
> replacement for the TID. I still think it would be a useful extension in
> general.

Applications will need a way to determine when it is safe to close the
pidfd, though.  If we automate this in glibc (in the same way we handle
thread stack deallocation for example), I think we are essentially back
to square one, except that pidfd collisions are much more likely than
TID collisions, especially on systems that have adjusted kernel.pid_max.
(File descriptor allocation is designed to maximize collisions, after
all.)

Thanks,
Florian


