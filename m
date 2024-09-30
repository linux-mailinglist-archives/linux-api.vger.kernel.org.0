Return-Path: <linux-api+bounces-2356-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D8989F73
	for <lists+linux-api@lfdr.de>; Mon, 30 Sep 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC031C20F25
	for <lists+linux-api@lfdr.de>; Mon, 30 Sep 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E61180A80;
	Mon, 30 Sep 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ldpq5Y/D"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE41D5336E
	for <linux-api@vger.kernel.org>; Mon, 30 Sep 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692414; cv=none; b=E954ffe2+6mCxUvdfIixA4E/96ueKzBEaVxRxjKgSFZeCxdy4C5/UbKp4+9pR/qOT8qABgatEkwDR4xZ1IyEEN8P4/etM8febInmNIDt0oOIymPbJF8fpNYbSEeez98dR8TqQv9cx6TsPkhu75v9HkZi/n0q++D4ypZNuTl3kZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692414; c=relaxed/simple;
	bh=GQWWTfHubQuieHaS/hviuz6e8IYCnUTftJg25TZvPag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUEUlqbD1DagV4fioNO+NWiSgf+4PjIvFq1ZoEFpxMqg2PUFI1+GZmyi2UWqWB8p2OY2uXJV3iB0IwF4g4C5eGT3dp1wO8NaYIgq7QnYxvCMy4ubTBZ3hyUq7k/TgdYwLqjA3NTW+X7r3Wf/nP3rb24USJ8uNjpqIXYsNGJ34WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ldpq5Y/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727692411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWjTQgM2FW5gQeC40mC/LxGIRFWdUXta0r321EYH9ic=;
	b=Ldpq5Y/DwoEiTUWhv2/z5rFcSbHK+k3AXSjocANlWS6Mw7y+KcardaqpN68f95XcCU6Y7Y
	yQC8nLBJvRfaDToMgNOcX8vGvuTqlPzUNckS0ToIReItSMCRjLVGMPCmFqvWs+WW5NqYVx
	YnmfF6fCnfFj1G9yFEAa/Ot+pp/3jjE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-CyjLEtWuNmOvKROz4UGw9A-1; Mon,
 30 Sep 2024 06:33:28 -0400
X-MC-Unique: CyjLEtWuNmOvKROz4UGw9A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 334A2195395B;
	Mon, 30 Sep 2024 10:33:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.151])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A708C1956088;
	Mon, 30 Sep 2024 10:33:21 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>,  Shuah Khan
 <shuah@kernel.org>,  "Liam R . Howlett" <Liam.Howlett@oracle.com>,  Suren
 Baghdasaryan <surenb@google.com>,  Vlastimil Babka <vbabka@suse.cz>,
  pedro.falcato@gmail.com,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
In-Reply-To: <cover.1727644404.git.lorenzo.stoakes@oracle.com> (Lorenzo
	Stoakes's message of "Mon, 30 Sep 2024 10:22:27 +0100")
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
Date: Mon, 30 Sep 2024 12:33:18 +0200
Message-ID: <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

* Lorenzo Stoakes:

> If you wish to utilise a pidfd interface to refer to the current process
> (from the point of view of userland - from the kernel point of view - the
> thread group leader), it is rather cumbersome, requiring something like:
>
> 	int pidfd = pidfd_open(getpid(), 0);
>
> 	...
>
> 	close(pidfd);
>
> Or the equivalent call opening /proc/self. It is more convenient to use a
> sentinel value to indicate to an interface that accepts a pidfd that we
> simply wish to refer to the current process.

The descriptor will refer to the current thread, not process, right?

The distinction matters for pidfd_getfd if a process contains multiple
threads with different file descriptor tables, and probably for
pidfd_send_signal as well.

Thanks,
Florian


