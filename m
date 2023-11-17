Return-Path: <linux-api+bounces-80-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C289A7EF4BA
	for <lists+linux-api@lfdr.de>; Fri, 17 Nov 2023 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3616DB20B39
	for <lists+linux-api@lfdr.de>; Fri, 17 Nov 2023 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8326F32C67;
	Fri, 17 Nov 2023 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVya5cUp"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6174CD63
	for <linux-api@vger.kernel.org>; Fri, 17 Nov 2023 06:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700232437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X9wOMp8/lcZxe3DczLGKJvGgQoyeF43B10JYtRm4Dvc=;
	b=DVya5cUp7NqJ8ioaBQHnJjJDKXf3EqltKfEHsYfauHxwcyo58N7qJsQm0f5PSH/KchE0k1
	pvwt8Bzop0lNAfvHYdPpKHXdUojPDrZAePnWWSDEzofPlC3pEJ9s+4s2Oilc68wbpKMdmS
	Y6Y08yvIUmPQenhO2zHDPAPMOEWX6+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-2HjE7GweOPyUgzyAt7wK1w-1; Fri, 17 Nov 2023 09:47:13 -0500
X-MC-Unique: 2HjE7GweOPyUgzyAt7wK1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5908811E7E;
	Fri, 17 Nov 2023 14:47:12 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AFD29C1290F;
	Fri, 17 Nov 2023 14:47:10 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: libc-alpha@sourceware.org,  linux-man <linux-man@vger.kernel.org>,
  Alejandro Colomar <alx@kernel.org>,  Linux API
 <linux-api@vger.kernel.org>,  linux-fsdevel@vger.kernel.org,  Karel Zak
 <kzak@redhat.com>,  Ian Kent <raven@themaw.net>,  David Howells
 <dhowells@redhat.com>,  Christian Brauner <christian@brauner.io>,  Amir
 Goldstein <amir73il@gmail.com>,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
	<87fs15qvu4.fsf@oldenburg.str.redhat.com>
	<CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
Date: Fri, 17 Nov 2023 15:47:08 +0100
In-Reply-To: <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 16 Nov 2023 22:01:27 +0100")
Message-ID: <87leawphcj.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

* Miklos Szeredi:

> On Thu, 16 Nov 2023 at 21:36, Florian Weimer <fweimer@redhat.com> wrote:
>
>> In addition to Adhemerval's observation that we'd prefer to have some
>> hint regarding the buffer size, it's probably better to have entirely
>> separate interfaces because it makes static analysis easier.  With a
>> unified interface, we can still convey the information with an inline
>> wrapper function, but we can avoid that complexity.
>
> I'm not against having separate allocating and the non-allocating
> interfaces.

Thanks.

> But I don't think the allocating one needs a size hint.   Your
> suggestion of passing a buffer on the stack to the syscall and then
> copying to an exact sized malloc should take care of it.   If the
> stack buffer is sized generously, then the loop will never need to
> repeat for any real life case.

The strings could get fairly large if they ever contain key material,
especially for post-quantum cryptography.

We have plenty of experience with these double-buffer-and-retry
interfaces and glibc, and the failure mode once there is much more data
than initially expected can be quite bad.  For new interfaces, I want a
way to avoid that.  At least as long applications use statmount_allloc,
we have a way to switch to a different interface if that becomes
necessary just with a glibc-internal change.

Thanks,
Florian


