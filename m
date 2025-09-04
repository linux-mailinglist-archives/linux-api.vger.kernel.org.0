Return-Path: <linux-api+bounces-4714-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254BB445C3
	for <lists+linux-api@lfdr.de>; Thu,  4 Sep 2025 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535741CC14FC
	for <lists+linux-api@lfdr.de>; Thu,  4 Sep 2025 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBE257837;
	Thu,  4 Sep 2025 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx4NOG4B"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908792505A5
	for <linux-api@vger.kernel.org>; Thu,  4 Sep 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011771; cv=none; b=q00RPfJeC249t20pTft0q9fgQwfhwavdXr3RoVLFhtGy9FDP3v12vHbpDVSASSUSx7OMBZI/QLdehdQ0L8fX/v6V1NpdVimDYAKU7uC9cfGYd83PB+PBBLOdeF2atvCM2UICho3l6K/SrXm8gCfAaYZEHOGf0XJTjkZl/sXEn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011771; c=relaxed/simple;
	bh=eXyQJfESFf7Aw5FLo55Mg6bEf+xMsXf9uIP9sy2EQtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NlAcUUZw8kpC5XTUj6jnc6N6SyJUK6V7eTp8A1vMp8Qy9Ok3ao6PdmJaKvMFOu1IjzaCKN/Sa2rBrWklyFODLKsbyVR8CjTmH6Spzhoa71kMt7dOblD/N6d/JvnDfHBY7sbJn3yVddIe6CSYh6WvufEulR3ROtZB/rqAeiVxOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kx4NOG4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757011767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXyQJfESFf7Aw5FLo55Mg6bEf+xMsXf9uIP9sy2EQtE=;
	b=Kx4NOG4BdgzDhhNVKQwp2KLL21g/pvlVEq2nNoqHUkZVUkZ/19DiR7xzgQPxlyoqIr29X9
	X0fkEKLy/DDsYkX8dWnRGi0xZG4HIDTqH/i/N5HJ4p92TQArIxk0N72dsWjoyohT09MZM2
	nQmUB7BCRjo1ECMTZu7eukmExJl7Ck4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-3A5xmutrNkSXJHhPd00MnQ-1; Thu,
 04 Sep 2025 14:49:24 -0400
X-MC-Unique: 3A5xmutrNkSXJHhPd00MnQ-1
X-Mimecast-MFC-AGG-ID: 3A5xmutrNkSXJHhPd00MnQ_1757011762
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA0631800378;
	Thu,  4 Sep 2025 18:49:21 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.87])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9FF3002D27;
	Thu,  4 Sep 2025 18:49:16 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,  linux-fsdevel@vger.kernel.org,
  patches@lists.linux.dev,  Jeff Layton <jlayton@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  Alexander Aring <alex.aring@gmail.com>,  Josef
 Bacik <josef@toxicpanda.com>,  Aleksa Sarai <cyphar@cyphar.com>,  Jan Kara
 <jack@suse.cz>,  Christian Brauner <brauner@kernel.org>,  Matthew Wilcox
 <willy@infradead.org>,  David Howells <dhowells@redhat.com>,
  linux-api@vger.kernel.org
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
In-Reply-To: <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
	(Amir Goldstein's message of "Thu, 4 Sep 2025 20:17:24 +0200")
References: <20250904062215.2362311-1-rdunlap@infradead.org>
	<CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
Date: Thu, 04 Sep 2025 20:49:13 +0200
Message-ID: <lhua53auk7q.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Amir Goldstein:

> I find this end result a bit odd, but I don't want to suggest another variant
> I already proposed one in v2 review [1] that maybe you did not like.
> It's fine.
> I'll let Aleksa and Christian chime in to decide on if and how they want this
> comment to look or if we should just delete these definitions and be done with
> this episode.

We should fix the definition in glibc to be identical token-wise to the
kernel's.

Thanks,
Florian


