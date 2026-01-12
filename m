Return-Path: <linux-api+bounces-5617-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61126D125A0
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 12:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF44304DB47
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B725356A10;
	Mon, 12 Jan 2026 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhOHW8P7"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE9356A31
	for <linux-api@vger.kernel.org>; Mon, 12 Jan 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218161; cv=none; b=MGMvDb2VllK76Jy2JUkKJ0CKOd2LMUInyE2Ko1B0u2Yu/9ZMg6RupK5fUQhLb3d0Jr7gQF2Uz/vfFHhcjqSxAfRoEaHP4Y8zmit4Sym8rwqwCqPc5OR6VZ2B2CBt9uI65lAf4pEm3nR+FX2/XnlYQj9whztZ1vbtB7EPI1XK1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218161; c=relaxed/simple;
	bh=/cZB6jAScdGWtlTD1wUvgFwqNswsMuCb5T8p3wPVa24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoAEotE1QC4Db4rovCBQ9x8uQhdvz5R0JkxOXyO/PODmWuuv5GaPc9VqOjJ8cgnSzKQWgbchptZ3/vSs0yO1sxaClvNHQc4FxEhNhhZQYKK1EFEy5SyogG18b+cQHMdE+W9guWm2LDsOkhaMX9tjyT7iUg+lmRm9vx3UfNU96yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhOHW8P7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768218147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVdsttuN8LG2+FSiw2KfXuXK5R+7mNaRXlQUP1M6CHk=;
	b=OhOHW8P7NjTLE4nI5hOwxav7q0M1XfJHQCN0YoCavjh+/eq4Njg8BLQPXx0aAtBF1RklqZ
	DSOFCy7qZ/TV6fDZeUdeD88mR8zS5PPnUlTQIsEG8f21lusk0MEqyJflydhbjVELdULJwv
	kQKu/v4t7fU8wtDq2j4rsoSRVKph2Ec=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-PR2pgkj8NdqOCA0nOnVW1w-1; Mon,
 12 Jan 2026 06:42:24 -0500
X-MC-Unique: PR2pgkj8NdqOCA0nOnVW1w-1
X-Mimecast-MFC-AGG-ID: PR2pgkj8NdqOCA0nOnVW1w_1768218142
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3FB119560A6;
	Mon, 12 Jan 2026 11:42:22 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76ACA1800577;
	Mon, 12 Jan 2026 11:42:19 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Jakub Kicinski" <kuba@kernel.org>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>,  "Eric Dumazet" <edumazet@google.com>,
  "Kuniyuki Iwashima" <kuniyu@google.com>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Willem de Bruijn" <willemb@google.com>,  Netdev
 <netdev@vger.kernel.org>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
In-Reply-To: <06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com> (Arnd
	Bergmann's message of "Fri, 09 Jan 2026 13:56:38 +0100")
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
	<20260105095713.0b312b26@kernel.org>
	<20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
	<20260106151313.1f8bd508@kernel.org>
	<06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com>
Date: Mon, 12 Jan 2026 12:42:17 +0100
Message-ID: <lhu7btnkqg6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Arnd Bergmann:

> On Wed, Jan 7, 2026, at 00:13, Jakub Kicinski wrote:
>> On Tue, 6 Jan 2026 11:32:52 +0100 Thomas Wei=C3=9Fschuh wrote:
>>> As for the failure in netdev CI however I am not so sure.
>>> Looking at net-next-2026-01-05--12-00, the only failures triggered by my
>>> change are also the ones from the bpf-ci. Are these the ones you meant,
>>> or am I missing some others?
>>
>> Multiple things broke at once so slightly hard to fish the relevant
>> stuff out from here:
>>
>> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2026-01-05-=
-15-00&pass=3D0&pw-n=3D0
>>
>> Here's one:
>>
>> make[1]: Entering directory=20
>> '/home/virtme/testing/wt-3/tools/testing/selftests/net'
>>   CC       busy_poller
>> In file included from [01m[K/usr/include/sys/socket.h:33[m[K,
>>                  from [01m[K/usr/include/netinet/in.h:23[m[K,
>>                  from [01m[K/usr/include/arpa/inet.h:22[m[K,
>>                  from [01m[Kbusy_poller.c:14[m[K:
>> [01m[K/usr/include/bits/socket.h:182:8:[m[K [01;31m[Kerror:=20
>> [m[Kredefinition of '[01m[Kstruct sockaddr[m[K'
>
>>                  from [01m[Kbusy_poller.c:12[m[K:
>> [01m[K/home/virtme/testing/wt-3/usr/include/linux/socket.h:37:8:[m[K=20
>> [01;36m[Knote: [m[Koriginally defined here
>
> Maybe we can change all the instances of 'struct sockaddr' in
> include/uapi/ to reference a new 'struct __kernel_sockaddr',
> and then redirect that one if the libc header got included
> first?
>
> struct __kernel_sockaddr {
>        __kernel_sa_family_t    sa_family;      /* address family, AF_xxx =
      */
>        char sa_data_min[14];           /* Minimum 14 bytes of protocol ad=
dress */
> };
> #ifdef _SYS_SOCKET_H
> #define __kernel_sockaddr sockaddr
> #endif
>
> This will still fail when a user application includes linux/if.h
> before sys/socket.h and then expects the structures in linux/if.h
> to contain the libc version of sockaddr, but hopefully that is
> much rarer. A survey of codesearch.debian.net shows almost all
> users of linux/if.h first including sys/socket.h, and most of
> them not caring about struct sockaddr either.

If you call the data member sa_data just like glibc, it will only fail
in C++, not C.  GCC considers the two definitions sufficiently
equivalent (even though glibc adds a may_alias attribute to meet POSIX
requirements), and duplicate definitions are permitted in C.

C++ with modules will probably support duplicate definitions, too, but I
haven't checked if it's possible to get this work with GCC 16.

Thanks,
Florian


