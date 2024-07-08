Return-Path: <linux-api+bounces-1883-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456F92A843
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 19:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D541CB210D9
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538E14A095;
	Mon,  8 Jul 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcZ+GL6G"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31E149DEF
	for <linux-api@vger.kernel.org>; Mon,  8 Jul 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460019; cv=none; b=u8u/hzNycIJpn5opPvyP48+41HAxsifsAcLUELRSCiaF2HWUw0g849rRCYuzagti96c6Z6DxmePJbIPI5FySvkI43t4XPnQKihSfrr+Z4oJ9+IkaOMVMaDLaHqnnSxns3lLuhHJDjJnpFZYbW6G0FCbvEk5yxF1JFvlm+6JmqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460019; c=relaxed/simple;
	bh=SGGTfSOeRUwxz6VC/qRrj5DKzqlNaTgG40wQSssXK7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OMuoR76FhYh6e5wO9Yj8avuD+HnrGspvdtgxVEAwbtCSJWtiRcLTZOMW4SUdc/pk52o81GWJbHhuMo5jeA49JOLzJxtqDI2LAYtM7Rn70UBlqa/3/4KyvitHnCQbJcUarSIdj8tSvxZAIAyUCjd8+XJJaq3VdfTeMewaCGAT6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcZ+GL6G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720460016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzysFrdc8w10bKEbWw8ppHuT/B9oi64/ANDYqxDHLjs=;
	b=dcZ+GL6GLJIiETs1lE/MRUKW4Gr7ga76nTBIZiT3xMShj5/wpx895ihribCdyx+Z27MUyF
	IYKTFnae9bLWW98ZNg4l2Ta1F7lV76dYyCR+oIT6ePjJD2lnb56tp4xfNXUoiwW6ed60Fj
	7MQl9iLH0byltNM0kyPN5eQfW38vK8I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-i2EE8bhrPTu-d51vmcgTDg-1; Mon,
 08 Jul 2024 13:33:32 -0400
X-MC-Unique: i2EE8bhrPTu-d51vmcgTDg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9014B1956046;
	Mon,  8 Jul 2024 17:33:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CE9B19560AE;
	Mon,  8 Jul 2024 17:33:05 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Jeff Xu <jeffxu@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,  Al Viro
 <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Linus Torvalds <torvalds@linux-foundation.org>,
  Paul Moore <paul@paul-moore.com>,  "Theodore Ts'o" <tytso@mit.edu>,
  Alejandro Colomar <alx.manpages@gmail.com>,  Aleksa Sarai
 <cyphar@cyphar.com>,  Andrew Morton <akpm@linux-foundation.org>,  Andy
 Lutomirski <luto@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Casey
 Schaufler <casey@schaufler-ca.com>,  Christian Heimes
 <christian@python.org>,  Dmitry Vyukov <dvyukov@google.com>,  Eric Biggers
 <ebiggers@kernel.org>,  Eric Chiang <ericchiang@google.com>,  Fan Wu
 <wufan@linux.microsoft.com>,  Geert Uytterhoeven <geert@linux-m68k.org>,
  James Morris <jamorris@linux.microsoft.com>,  Jan Kara <jack@suse.cz>,
  Jann Horn <jannh@google.com>,  Jonathan Corbet <corbet@lwn.net>,  Jordan
 R Abrahams <ajordanr@google.com>,  Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,  Luca Boccassi <bluca@debian.org>,  Luis
 Chamberlain <mcgrof@kernel.org>,  "Madhavan T . Venkataraman"
 <madvenka@linux.microsoft.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Matthew Garrett <mjg59@srcf.ucam.org>,
  Matthew Wilcox <willy@infradead.org>,  Miklos Szeredi
 <mszeredi@redhat.com>,  Mimi Zohar <zohar@linux.ibm.com>,  Nicolas
 Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,  Scott Shell
 <scottsh@microsoft.com>,  Shuah Khan <shuah@kernel.org>,  Stephen Rothwell
 <sfr@canb.auug.org.au>,  Steve Dower <steve.dower@python.org>,  Steve
 Grubb <sgrubb@redhat.com>,  Thibaut Sautereau
 <thibaut.sautereau@ssi.gouv.fr>,  Vincent Strubel
 <vincent.strubel@ssi.gouv.fr>,  Xiaoming Ni <nixiaoming@huawei.com>,  Yin
 Fengwei <fengwei.yin@intel.com>,  kernel-hardening@lists.openwall.com,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
In-Reply-To: <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
	(Jeff Xu's message of "Mon, 8 Jul 2024 09:40:45 -0700")
References: <20240704190137.696169-1-mic@digikod.net>
	<20240704190137.696169-2-mic@digikod.net>
	<87bk3bvhr1.fsf@oldenburg.str.redhat.com>
	<CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
	<87ed83etpk.fsf@oldenburg.str.redhat.com>
	<CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
Date: Mon, 08 Jul 2024 19:33:03 +0200
Message-ID: <87r0c3dc1c.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Jeff Xu:

> On Mon, Jul 8, 2024 at 9:26=E2=80=AFAM Florian Weimer <fweimer@redhat.com=
> wrote:
>>
>> * Jeff Xu:
>>
>> > Will dynamic linkers use the execveat(AT_CHECK) to check shared
>> > libraries too ?  or just the main executable itself.
>>
>> I expect that dynamic linkers will have to do this for everything they
>> map.
> Then all the objects (.so, .sh, etc.) will go through  the check from
> execveat's main  to security_bprm_creds_for_exec(), some of them might
> be specific for the main executable ?

If we want to avoid that, we could have an agreed-upon error code which
the LSM can signal that it'll never fail AT_CHECK checks, so we only
have to perform the extra system call once.

Thanks,
Florian


