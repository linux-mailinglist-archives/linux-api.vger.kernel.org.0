Return-Path: <linux-api+bounces-6081-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BP/Jh2S2WnLqwgAu9opvQ
	(envelope-from <linux-api+bounces-6081-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 11 Apr 2026 02:13:17 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A3D3DDAB5
	for <lists+linux-api@lfdr.de>; Sat, 11 Apr 2026 02:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B73301F4B8
	for <lists+linux-api@lfdr.de>; Sat, 11 Apr 2026 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973BF19CD1B;
	Sat, 11 Apr 2026 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+JhW4Hw"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091F175A79
	for <linux-api@vger.kernel.org>; Sat, 11 Apr 2026 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866390; cv=pass; b=tTISIqQz84ezWTz2NXyjNyQZPbbg1R4gWnJMLYDLRX9ZIXQp0AO+xtCHQYUJHkZMQhSb95uP6rSpN4DosEsoOSWTzG9fGvlAaniAzR70IYEPYkzgVc2ci4WkYisi0cwKhWFD/d5A2wzLHzInKDF197hQSOHDQokCc7LPIBddwYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866390; c=relaxed/simple;
	bh=5g2ngVaT7KNNrtzCpaG3e7jivMMatnwCpscSMG0DHss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhTi6hJKiji5hPONT0iO9vNVxHu/NG2N/WqRKAX7mv9BR2O88fvRlX3vna0L0pxXRGpJh1sc8mWrTeKSsjv44/2T2YgwMcHPwd+jhQB3G00EU+R6Q5qLP54dLmnnjFmzYnZQZRl8bX2ZBrOnttfpOG2N/6JRCD9S7d6l+fUV7Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+JhW4Hw; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso18626835ad.1
        for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 17:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775866389; cv=none;
        d=google.com; s=arc-20240605;
        b=C3AqY7LnVb27r1ZCIh7qhq01ufBj1DpWsoJlG7OBXFKU2EIsHPvQtI6XoSzQnPqj8u
         CnWOs4Q86MgR932vyJpOYUgEVvfFyssvjqKVIQ6pqlxGCx6OVfeYNl6UOFcV44zD4cbB
         rLReJ58DnNQSI3nCsmHGf7rQIks5s7mWgte+4PMG8gO+9MX9B6SbAmYuFjoAiWvtxWiJ
         Q81g7PIN07EE7NTWsl7D1fvwKTD7GQrb7FEu5y13npS4DS/iDKoFdhMMwVqgUkH7RTST
         od4/FqVkRXv7WXYZljBy7e6LAXFrW8VdmrB7xlBJu9yOTO3Qp2xR9vfqQPywGZYkQlCK
         xlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsQjBougx6I5pS8hQ5FNYADy1c2UftjAjB5FYmEah0o=;
        fh=71NgugSUbcVsz+0gK1ZyDTTbguGzl+KkYkhihLizP68=;
        b=b2ZfWTDys3l5X3CHjHFJ/vIb40UdEG8w93QxCXOTxLGZPbgfIegynvarFrH9Yvt4vO
         LfaEZX6NvuPsFJhTc7DpTcJlTN1ySrOyPFdFfnykljU3Dcw1IMLsjft0X2L4fHYYIA+G
         D7uq6eUPNIJk+5/2TfPFUJBKgxCphhmOaciaqJiOlcb5sh73qPY9zFhDljR4GWYgA97K
         ik5ibG71nnlBmdhzQYS3wbWFG8jFvcqFifs0VEbfgzlJDFKGdR3M8sW+G/IThnmk9eCS
         nHhgDDDI12/oHM60BA+fmpjUt+dJ2OSTBfazWF/Mps4pfOjSAVc31nUpiojefGYCcguG
         b1sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866389; x=1776471189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsQjBougx6I5pS8hQ5FNYADy1c2UftjAjB5FYmEah0o=;
        b=J+JhW4HwX0mufgwsTMijVlFYIIiyZ07BSyoxdiDVE7QrEfVljtV7GPmy2srYGd6xLy
         nWWAND/XNRO3QpQGS5jQcmXldhmACvjXkn4VdUN3k8hNVJod3zy0gKXo0X5ovRz3nbx7
         YqMy3pewclLgdLJJzbUS0Vz4Bu80JAwi5LRRncaBKNmosTZXNxOqFbz0d49283QPHNkO
         ojE3V/x5BMqGvIs7y9/dFUAFJpgBGt4iljm7VNKMDjCXH4HHxGSGH+7yZAabLpy3SJ08
         YQxTSjEYucB5lD7OYoo+2oCSyZZ3p6f6KJeO4+lyxdsctHI8XEfvDJxg/lx/GqV3ySC3
         7dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866389; x=1776471189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsQjBougx6I5pS8hQ5FNYADy1c2UftjAjB5FYmEah0o=;
        b=Dex0hLNKX1cOp/LQOnD0mFk5pMoEB8zDlUlFULxETRDj6BPmydHzvioAgd0kPMcFd7
         0O4eKwxDALxiCNfmIA1d9wjiCjB1Lf5+byGNL1urdhY7wcdm+aVxBEDICpv+7OXZZ9Mj
         GVerDIBY7fLuwb8/fzr08rs2LImBrdLenkLwuiibGmsh9xLJFw/D2m9+d9bdqYq0wCV8
         xe0jP2BKfNAO/RlaT+MkrFvUpJSXw4aNlFeODIaLYtmW2M65oosw5+/fcnbi2C5mf3CA
         SqldRMnjsf9m4OqDaE3LdGq3IcPPTcBrudvySko1YdVWjlcx37tyos+Fqm4XySY4/ESo
         AW9A==
X-Forwarded-Encrypted: i=1; AJvYcCXqgRS9PK9elhbaDYjIOfhIolfoTcEMUVtGzxZ9hnhdOWFADruxJyRest8OmUZqoDJ3j7HLNDfcX7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsclSGv1wEYox6vnr6U9YQag+XNPRiRv9v3tqvmzRvoVpMrhWC
	8o5h3Xd96ujt8HOqGiulPvNNzpCnKYx8oqVgGasU48A5W0+E3bTB74oZpLy8jOZKH8irHIuFyj7
	+mJLt0SvQxfZCOA93a8OiNePEpagARpU=
X-Gm-Gg: AeBDiesYFa/U+wwYbhNwBby5EEVGJmxs9tUg+eBZPM7G190uExaxu8H9mP4od3UXBDj
	tRAQWWKukwBHt3vS2NEPYCWFdJCFZwwFWqwKLKS8fOjl9h4CYAP9sVc2taJElyLc36LsGPEJm5p
	OJkzOOo9pRjTUzu7CDvISaH3ZQCIi62nBrzCQjZpYP9QpHlsRuKKHqrQvz/Ip9X18toiNbpL0Rc
	GroX4aGRzJS7rhAuSzNSiOrylnbfJ/ZloMgL9EzTH0bR6SS/Mewyli2D1zPuiqswGZ25fEfEVfK
	Zojx+tfu2kl347pMKg==
X-Received: by 2002:a17:902:f9cb:b0:2ae:6457:3099 with SMTP id
 d9443c01a7336-2b2d5a307f5mr39168585ad.26.1775866388658; Fri, 10 Apr 2026
 17:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
 <lhupl47e0lc.fsf@oldenburg.str.redhat.com> <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>
 <d095cc40-5217-4318-ae2e-40e5fe3be47a@p183>
In-Reply-To: <d095cc40-5217-4318-ae2e-40e5fe3be47a@p183>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Sat, 11 Apr 2026 08:12:32 +0800
X-Gm-Features: AQROBzBXpVj5q_p8EOJEIpEPhw6-uu_-Cq0WNPK494rLa4BGus9wqYsxF3KY2Jo
Message-ID: <CAMe9rOoOAmDbgsq=8fNKqR1WzahD6oAB5qHfscrivCQdSWdg4g@mail.gmail.com>
Subject: Re: Avoid reading /sys/kernel/mm/transparent_hugepage/?
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, GNU C Library <libc-alpha@sourceware.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6081-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hjltools@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: F3A3D3DDAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 4:35=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> On Fri, Apr 10, 2026 at 03:40:30PM +0800, H.J. Lu wrote:
> > On Fri, Apr 10, 2026 at 3:28=E2=80=AFPM Florian Weimer <fweimer@redhat.=
com> wrote:
> > >
> > > * H. J. Lu:
> > >
> > > > To enable THP segment load, ld.so opens and reads 2 files under
> > > > /sys/kernel/mm/transparent_hugepage/.   This requires mounting
> > > > /sys and is expensive.   Is it possible to put such info in vDSO?
> > >
> > > Alexey Dobriyan proposed adding AT_PAGE_SHIFT_LIST to the auxiliary
> >
> > Does it cover
> >
> > [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/hpage_pm=
d_size
> > 2097152
> > [hjl@gnu-tgl-3 linux]$
> >
> > > vector a while back, but I don't know the status of that.
>
> Status: nothing happened.
>
> > How can we get
> >
> > [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/enabled
> > always [madvise] never
> > [hjl@gnu-tgl-3 linux]$
>
> This is not covered, see the link:
> https://lore.kernel.org/lkml/ecb049aa-bcac-45c7-bbb1-4612d094935a@p183/
>
> PAGE_SHIFT_MASK should be folded into system call probably.

We need a fast way to check THP status for THP segment load.
A system call to return /sys/kernel/mm/transparent_hugepage/enabled
and /sys/kernel/mm/transparent_hugepage/hpage_pmd_size should
work.

--=20
H.J.

