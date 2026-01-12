Return-Path: <linux-api+bounces-5619-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD361D12CEA
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 14:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A447E3015953
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CB330339;
	Mon, 12 Jan 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4UtK85o"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9528506A
	for <linux-api@vger.kernel.org>; Mon, 12 Jan 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224342; cv=none; b=TehLK2QFXQsFe4+eT0cUEyr9A3O2p22PAXyiLTTW5sEEXg2d+wwv8rjZrxXrxxsMsx/MvMjT+wfZlOm9Kyni/tpVznm3vC6v5RYQ5gjI99pr3WNc9RqBavxtaTJHjVobjLWX+GHi7c+nE1dtDeC1HrL5BYedxCNIZBenGHuNz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224342; c=relaxed/simple;
	bh=x0YNOdM+ctmecPZk+Jkix0XUJyfewE/Ff1dKHXqpWBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xp9vq4J7AWXfBL92BQigwVm9RLgLZiOX8K1kaihomMi01PnV489lCnB8vsu3wCIGU1HTV5hLf91nAdnrZognyrRxAnUdyP5OSuTS9DH0J2ZEJbb3nyZsW5mg4H4yxMw0OcYiF4FRGAenlSYnZdvPs2936UopWRXYmVolRSBLnsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4UtK85o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768224337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j55coe+3ogEU9UNSDZ1oIEXEqPhWjD615rcMEm1F0gQ=;
	b=S4UtK85orayzhoTgHyYtEtke66mq4h/FC6u02/Eew2Vipl2Sp2Eypm8j8TGZnjAE4z2Z9V
	aZr71tij34EjQmds24OtETGr5Ao2skMn4OosOUGPv9e1HVE9gVzg31WyYL13kp6745yPwz
	mu0TD8lLagDp0hYjXAs+HCfkq3m/88g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-vTz3vBllMH6ASN4CCwExig-1; Mon,
 12 Jan 2026 08:25:34 -0500
X-MC-Unique: vTz3vBllMH6ASN4CCwExig-1
X-Mimecast-MFC-AGG-ID: vTz3vBllMH6ASN4CCwExig_1768224333
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4789D1800BE7;
	Mon, 12 Jan 2026 13:25:31 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3721A1955F43;
	Mon, 12 Jan 2026 13:25:27 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,  Jakub Kicinski <kuba@kernel.org>,  Eric
 Dumazet <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,
  Netdev <netdev@vger.kernel.org>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
In-Reply-To: <20260112124604-dbf7f68d-2182-438f-9495-2931cac02a81@linutronix.de>
	("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Mon, 12 Jan 2026
 12:55:07 +0100")
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
	<20260105095713.0b312b26@kernel.org>
	<20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
	<20260106151313.1f8bd508@kernel.org>
	<06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com>
	<lhu7btnkqg6.fsf@oldenburg.str.redhat.com>
	<20260112124604-dbf7f68d-2182-438f-9495-2931cac02a81@linutronix.de>
Date: Mon, 12 Jan 2026 14:25:25 +0100
Message-ID: <lhutswrj73u.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Thomas Wei=C3=9Fschuh:

>> If you call the data member sa_data just like glibc, it will only fail
>> in C++, not C.  GCC considers the two definitions sufficiently
>> equivalent (even though glibc adds a may_alias attribute to meet POSIX
>> requirements), and duplicate definitions are permitted in C.
>
> clang is not so lenient and will error out.

It seems it accepts it if you switch to C23 mode.

Thanks,
Florian


