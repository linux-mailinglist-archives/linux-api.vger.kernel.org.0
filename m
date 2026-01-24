Return-Path: <linux-api+bounces-5746-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMk4AI6bdGnH7wAAu9opvQ
	(envelope-from <linux-api+bounces-5746-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 24 Jan 2026 11:14:38 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E487D311
	for <lists+linux-api@lfdr.de>; Sat, 24 Jan 2026 11:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C21F5300C819
	for <lists+linux-api@lfdr.de>; Sat, 24 Jan 2026 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48923D7CD;
	Sat, 24 Jan 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYKPH+/w"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613131F03D2
	for <linux-api@vger.kernel.org>; Sat, 24 Jan 2026 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769249672; cv=pass; b=kTz//7h14iGqnMmcYbHrgpYbE3mKwYxj8SStUDZsMVAQbfPmNIE6Mm/cncKcBlpSuQe+WbnMilh4A4FJZMJ8Zd0brt3CVILxakezygzKYMKNhC9ToWUpSFd2vn5ufeSeLevT+JovoVTX5F3ebQeAebqZC3Tq6Nej5EcM3z6Bptk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769249672; c=relaxed/simple;
	bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHhlgKwdG76c4awXmWwUeW75SpUP/m04SsS6WLvqeX4lbccDjg7CtZHvtbhOz1vLc5NF69XOd8cYIII1BF3FZ4dtr5eC5rEmx/OZWE1fP/Fn7qnUut23+/5tZekh0FIXleGUCPsjEw4BH5LDux/eUs8W3FjYtiwjI9ttbMwulEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYKPH+/w; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fdb90b670so28309667b3.2
        for <linux-api@vger.kernel.org>; Sat, 24 Jan 2026 02:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769249670; cv=none;
        d=google.com; s=arc-20240605;
        b=TkP+fxKSus95fl6YCeKPHmJhdOE7sfMKRiJLOoa+f8L6+SSOVNev7beQKaya52XeDd
         a42YZr9cSEc5Mzu57vRiviG3npmu1kDAtfirv1WdgsE9N3R55wi9Ne87jZX+DA/Reh1x
         AyEQatfvU4FpmUAlJ78YNAaxmvSnFnDdfTNRNYRCA2psuhL5Ug4iYO0rqUFL5D3i2fKS
         7HXfCFMRbWKWmMsqqIuCYZkcXAwzVodKm9/RHDdirTX/tZ/Fp/AYBXZoRITWXB6eLzt9
         T/j8q7yJY1fW4dQF2/YToPPYkzshMX3dq2F1pxxl1isel2poYPQFh18zsNrZdGgDepuC
         TBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        fh=WI+4TOwticviKVN+nKByHEQ2GNNx188ZZUAieSGrXzg=;
        b=ODmwyasoxhlC5aKszIxm5adApu/C20Dp2Cc2WL87yHILqOhOttdepfvoYBY9PIMKIg
         1jFGRT0YIbb71+NhIAFeH+Vec7L2tUDXW0qWxOTgn3MU63HgABFhKxWFdvE0cb7gv4wp
         gM2Mr3c6hAMz66d2x3IBlVMl82/17mHbnEhbHkq+1mmwZbDqeb7k+YcMDPa6XcMe9XkD
         N1LnR2wYNe05KMsN/KC5yk4hLp2xaQFNtXbuCSQ4prd3X8bD8LBYcRADb0b6q7dwRGtI
         CJAa/SDRgHjVEDxgEIuM+XJaXuVfTetcVXdeLeSL+skaJ2Blnw6qTp1Ey1brjVRGDXHf
         XvGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769249670; x=1769854470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        b=EYKPH+/wt5Eddu1G8cutJCykY64wRsqS81cGNPuweZHYzmMt3HGx5LAEVmTLb/FYeM
         dYrJFBz2dnknohxDH2VbhCx4XTlD5Arfp8NeUV8TiDn5lNE0MB8qslWf0JVJ3jRzCdBZ
         MPU9YE1SUPcVvr/LyhzsfVJFVdYTX/aSWP+HHIE4pLRpn1YmBLaVoF2RTwXvURZyqBGk
         efG2VKqIRU/wLhEqRDjMVIai61v9RuDYTqC7REDNPzCQeeJFjfBWh5QuWn417dtyu1ct
         vC77iCxMpwZcgxhBIKy5uBHQko/VZ//urF+UA9hb1csVkBI2REguxoZ9/M1WP0hwnViB
         3aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769249670; x=1769854470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MM3onG4tUxgwOKfJm5InIVjKBkXtm5OCZzzHG9w3m4=;
        b=MczXHGBgWKAbt6TqrZnJ8vACwvgn3Pyc+gHJsYtLUu5fD7ik4hBfWWXBbZr2oq+RAQ
         9KF6IcN/8KBOsKRZaq/2yqkQ76GTrMEtymkxDZOqPVy6CCKtSqsfKs1P0Jqx8JVjLikS
         imOpzp56zC+FfH15RlKQvwszBf/O+QLMtUPzYbfmykVuhfyOMamUn3XwmDrsO0W9IvUI
         FzCB/t0wdWok1aRhR2SwYuRO4lTChBkdfcQjc6wVv7KHnxFdXKdNaVGmD1Ez3sCqX3/C
         4TcuUVuaEPLYFB/iUb0Dm3Y8rygCoZpZol8JHrNW4oPUCn1oGDKmNzAR0Eok12Eid8tc
         EKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb1BFk/fujgDlW4824RqEas00n2wtUoqSVJS5K20Ji38sK8Arho/bxX5aQHLVdwXJTdigYozy5UVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWUIk8l4Pt+p/qECO7LtJI9SHhNQJFBvTEW/6F1bZdBVCPfVs
	JvDVB7WGAY1yRQDyOqQnfugrH4au6UxgKj2ApZ2R41xpxoeb3E5OTVnnLMFnYXEQAEkDIEghe4S
	2Mu5/Gr3TVle19MtiFFbZXIYU7b7bQy68nmDpew0=
X-Gm-Gg: AZuq6aLkLH1lwHBrm/KRYVmhtfJn/8WHEBI5iCZdSBEBcIZWQtxwxsTFnPMQ1eKNH6u
	S35A2zWaQDtN+jYHnBtfKp79dT81bQpZi23pyuomsZLLtToxiF/UCCANGcKPLlB1xOZpngrzfVX
	VRzRvKj6eCIm5e+WlHolyLL22XxcgXXCYKC3I0JHSMO7tsABCrzwKtjBOli4H29oLQ0x0JLZjoU
	7sWCJKIAsBNowbQzU2257CEgixLzZbF1Q2M7EydKQV6DJReAuXNIgRcsDOy8OIxPcn0Dhw=
X-Received: by 2002:a53:ac82:0:b0:649:3970:fa88 with SMTP id
 956f58d0204a3-6495bece06cmr4745338d50.37.1769249670198; Sat, 24 Jan 2026
 02:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20260119171101.3215697-1-safinaskar@gmail.com> <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
 <acb859e1684122e1a73f30115f2389d2c9897251.camel@kernel.org>
 <CALCETrUZC+sdfpVqqjeC_pqmd+-W84Rq7ron8Vx9MaSSohhJ2g@mail.gmail.com> <20260123-autofrei-einspannen-7e65a6100e6e@brauner>
In-Reply-To: <20260123-autofrei-einspannen-7e65a6100e6e@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 24 Jan 2026 13:13:53 +0300
X-Gm-Features: AZwV_QgI2djWv53heJq45UjjcmWS5t43scQ8_DAQPG3PfhZnXr_aF6xvpALbmMM
Message-ID: <CAPnZJGA7jbQAAV09Lr+NKNwRvKmegZFC=LzOZybWG7skF4rpQw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Jeff Layton <jlayton@kernel.org>, amir73il@gmail.com, 
	cyphar@cyphar.com, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Lennart Poettering <mzxreary@0pointer.de>, David Howells <dhowells@redhat.com>, 
	Yunkai Zhang <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5746-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[amacapital.net,kernel.org,gmail.com,cyphar.com,suse.cz,toxicpanda.com,vger.kernel.org,zeniv.linux.org.uk,0pointer.de,redhat.com,zte.com.cn,lists.linux.dev,phoronix.com,lwn.net,landley.net,lst.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 52E487D311
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 1:23=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> The current patchset makes nullfs unconditional. As each mount

Oops, I missed that "fs: use nullfs unconditionally as the real
rootfs" is present in vfs.all.

--=20
Askar Safin

