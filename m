Return-Path: <linux-api+bounces-6072-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHVQKi/M1mlgIggAu9opvQ
	(envelope-from <linux-api+bounces-6072-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Apr 2026 23:44:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443943C4286
	for <lists+linux-api@lfdr.de>; Wed, 08 Apr 2026 23:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D13230117E9
	for <lists+linux-api@lfdr.de>; Wed,  8 Apr 2026 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E6376BDE;
	Wed,  8 Apr 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IDpvQV4B"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941133793BE
	for <linux-api@vger.kernel.org>; Wed,  8 Apr 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775684653; cv=none; b=hz8tUBPAVnbDLo67LtkV86w+gOmn5mIYupVN/qPscsxim0oxRR2EhmHAdZmPO3qShXGUth2Bk+NzNWYCZ+nlKvbHov+Lk4qOg9RYpijiobygoXyrwBDqUd23f8l/9bYEy6xB/y+CoI+djaisBJWYkrOaP6kLBKhzQ/6EcIn+AO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775684653; c=relaxed/simple;
	bh=rd3HDVI0C6RgIhv3O3KHgLWxlh7P24wXk9l3FDC4sO8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aOw9bZr3OZlsOPaqDgDnQDriHhLKdNj0RKKt+CvtJ+gZ53/6QCpJsRnCfjnnitwH0CIZ7gZTjKLmlixDv24lKWq7KEJjb9D2yM+vkwqnkO8F5EStl1sgAeZ3guCxPyfru4YzlKLW9+lEolAJ6n8p1bYx6ep+u+gyAKikj7+ogeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IDpvQV4B; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 0f640b08-3394-11f1-afda-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0f640b08-3394-11f1-afda-005056994fde;
	Wed, 08 Apr 2026 23:44:03 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 0f61c3dc-3394-11f1-83d7-00505699891e;
	Wed, 08 Apr 2026 23:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=L6yY1vRidVgRuaU+kukO84bm0idAZPOfAApm1LSPy7g=;
	b=IDpvQV4BDedHJKedJjJ/SR3enahmAYGy15ARnCFU5gYZdUu80iUvDZc/smmis8aJqZqoSG6TlZYUD
	 VC5ZY5xbAzgHIOrzfdUaJ41+AP5XcnExMaLOiHEZdu0r27vvQlI7gi+mklDzIoIWUuCSVZyF8vR3gs
	 AUpQJiAnkR052QTpQZ4p729tm4j86TLhj624sPGMQshsR0FJ9TwKT1zA+E9MB3vb9aAqTB6UMifOtk
	 mnBWlFoD8seC1hidd89h0NASHNB9QgBDhkMgUgyaSZG61VIYRG3KzasV9QdrUrYacbf/866pXiKnXn
	 fnQKxs1XxtSUj/EHzYeN/ksU7NiQ+CA==
X-KPN-MID: 33|/UAggWUo9xsQ/7Ro5rHTE9aGV79mwhCmNSNSiCW0tmi9xuDLVtzXghyTg1uCXnA
 cF3fy5oGM+n31k+RLT2A4LtHOimUXCSdgUuUnODvH1NY=
X-CMASSUN: 33|k4bWsyZRQIuoY3Wo5ZYj/E4TlOHekJIvZ+sitMXHs3GowORHNEvD/XZzum5Bi73
 cLmCATHi3FhPdjggEZNvxiQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 0f565b90-3394-11f1-b8d7-005056995d6c;
	Wed, 08 Apr 2026 23:44:03 +0200 (CEST)
Date: Wed, 8 Apr 2026 23:44:03 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Aleksa Sarai <cyphar@cyphar.com>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, cmirabil@redhat.com,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Message-ID: <52244194.1650546.1775684643065@kpc.webmail.kpnmail.nl>
In-Reply-To: <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
 <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6072-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[cyphar.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kpc.webmail.kpnmail.nl:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xs4all.nl:dkim]
X-Rspamd-Queue-Id: 443943C4286
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 02-04-2026 04:52 CEST schreef Aleksa Sarai <cyphar@cyphar.com>:
> 
> Please do not use O_* flags! O_CLOEXEC takes up 3 flag bits on different
> architectures which makes adding new flags a nightmare.
> 
> I think this should take AT_* flags and (like most newer syscalls)
> O_CLOEXEC should be automatically set. Userspace can unset it with
> fnctl(F_SETFD) in the relatively rare case where they don't want
> O_CLOEXEC.

And then do something like statx_lookup_flags() does to build the lookup
flags from those AT flags? But there is also no AT_ROOT_CONTAINED (or whatever
you would want to call the RESOLVE_IN_ROOT AT-equivalent) right now.

> Alternatively, we could just bite the bullet and make
> AT_NO_CLOEXEC a thing...

What's the bullet to bite there?

> 
> But yes, new syscalls *absolutely* need to take some kind of flag
> argument. I'd hoped we finally learned our lesson on that one...
> 
> -- 
> Aleksa Sarai
> https://www.cyphar.com/

Thanks,
Jori.

