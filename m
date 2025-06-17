Return-Path: <linux-api+bounces-3927-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A17ADC2F4
	for <lists+linux-api@lfdr.de>; Tue, 17 Jun 2025 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B5188FECE
	for <lists+linux-api@lfdr.de>; Tue, 17 Jun 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B204F2609C8;
	Tue, 17 Jun 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFZV9hsL"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C528C5D9
	for <linux-api@vger.kernel.org>; Tue, 17 Jun 2025 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144443; cv=none; b=AHgpIaVd6g1yj1RfA+wYP3IQ5m4mKFBTeZSfJ/fKlbXTYLqZPyFPbJV1piFyKOpFEavYAcYefjyrbA9oewdKMs0PZ0kGGHJ6MoCP/UCfDfIJETceS7AlvmHAKlQHkkoenQ62I63EfPlqD9xy5YQ5LH7h1SCYojiFzh08WKLAVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144443; c=relaxed/simple;
	bh=qJY8bj9CtbYWcniHkdEgxnX7+YzcTn7+I2xj0uZMQIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YnvAMwaxjX7ohGmUW80Eit0xNU5VmeZ4PzCq2ntCmH7P38ratOuKYiSVUpLJ+V/xoSRwH9XVPcxOhmjOiqpMbEu3YM40HFGxun8jvDPcmuFxsMCV7Ib/ko7XFNTSyhuyldwi9JdPxCIO7K+e5hjKMuzVnl5FeeXI5Cu7QpnEW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFZV9hsL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750144438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPf5/BotB2xeNpXMqUEi097upqbb8LBKJ2dT9gWuPvU=;
	b=MFZV9hsLwXXChY8/hHicGASFvYKypJJ53J0+1yW7NgmLx8hQShJMeGxBS25qILzRmiE++z
	hkQ0Efj5IeMa0Z0cJmpTOsjsH/TvG/KxUDJLxaFt2QpXoP7b1qhba569DPVZoRV7GKdjxS
	/iC45c1/ytF9uQsR3aY2OZFxXCTe3xY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-5rCRh91LPYOqx456wpzUNA-1; Tue,
 17 Jun 2025 03:13:51 -0400
X-MC-Unique: 5rCRh91LPYOqx456wpzUNA-1
X-Mimecast-MFC-AGG-ID: 5rCRh91LPYOqx456wpzUNA_1750144430
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 609A71809C80;
	Tue, 17 Jun 2025 07:13:50 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 604C01956094;
	Tue, 17 Jun 2025 07:13:48 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
  workflows@vger.kernel.org,  tools@kernel.org
Subject: Re: [RFC 08/19] exec: add API specification for execve
In-Reply-To: <aFDKHhaqB75Qi212@lappy> (Sasha Levin's message of "Mon, 16 Jun
	2025 21:51:26 -0400")
References: <20250614134858.790460-1-sashal@kernel.org>
	<20250614134858.790460-9-sashal@kernel.org>
	<87ikkvv018.fsf@oldenburg.str.redhat.com> <aFDKHhaqB75Qi212@lappy>
Date: Tue, 17 Jun 2025 09:13:44 +0200
Message-ID: <87y0tqu9g7.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

* Sasha Levin:

> On Mon, Jun 16, 2025 at 11:39:31PM +0200, Florian Weimer wrote:
>>* Sasha Levin:
>>
>>> +	KAPI_RETURN("long", "Does not return on success; returns -1 on error")
>>> +		.type = KAPI_TYPE_INT,
>>> +		.check_type = KAPI_RETURN_ERROR_CHECK,
>>> +	KAPI_RETURN_END
>>
>>Is the -1 part correct?
>
> Maybe :) That's one of the things I wasn't sure about: we're documenting
> the execve syscall rather than the function itself. A user calling
> execve() will end up with -1 on failure, and errno set with the error
> code.

Well, it doesn't say execve, it says sys_execve.

> You could argue that it's libc that sets errno and we're trying to spec
> the kernel here, not the userspace interface to it.

And I think this would be appropriate.

Note that in the future, the glibc version of execve will not be a
straightforward system call wrapper because we need to obtain a
consistent snapshot of the environment array.  That is actually pretty
hard because we cannot atomically replace the process image, unblock
signals, and unmap a copy of the environment.

So I think it's best for the kernel to stick with the system call
interface and not try to document what libcs are doing.

An even more thorny example are the setuid family of system calls, where
the kernel is extremely far away from what POSIX requires, and we have
to fix it in userspace.

Thanks,
Florian


