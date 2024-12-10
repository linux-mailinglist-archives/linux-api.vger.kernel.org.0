Return-Path: <linux-api+bounces-2885-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD39EBBE0
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 22:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532741686EB
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9E5232380;
	Tue, 10 Dec 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pu1gGKR/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C0232364
	for <linux-api@vger.kernel.org>; Tue, 10 Dec 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866170; cv=none; b=dk3D1NhLZ+O2btF8Ddho9M1zhjdIuwHktzC+KItIn7jQz2SxjDKgNj0xxKGr+H8TgNd5/OCHSmttJC1ggougChGRBligPhhYzoF0P7Wt1dcWF+WyvGg9iUSdOO3WK4r2Fc9PJABsDU3Us7Ok++TJdc6RjCI1VUpVecsXivg1Rg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866170; c=relaxed/simple;
	bh=tK2/X1JBOLK9LhfA5nyWkY8TdZ0unpl0tmomD/llBWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AalVfyWHnA3528BdOCqBA92/eRaQff+BTbd6uhiNk3ez5IhpkF/kDkSBo0HludVimk39UXMgYB5rL9AzZEupkHO5A0dwumZSalYWAe39beFLXGTAy0Scv0Y/jTw+OJydP6nrAUnpRfnGRM7X5mXqv7QYwWVW9NmBsU53U/LFwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pu1gGKR/; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e398273d6ffso4552051276.0
        for <linux-api@vger.kernel.org>; Tue, 10 Dec 2024 13:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733866167; x=1734470967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1nM3RAlxJRatFMEsNUSDK4GfiwoTfrUPqBU/Vy4UE4=;
        b=Pu1gGKR/cmfBok1oY7f2HJEElhjeB6JiUB9DWBHFLzkJVUCTYEooJstac0aOsPZV5V
         /a+vNbg0LWFE7ILBSALg0SC97hx7LdyCRkmea+kR/Y40g0zBGoA1OVWBBqitYHPGuaz+
         7Yrk5TEchfW/YQi3r5xvZvWhlWs5AEVdY4iAqLN9+0Tv8EzZXkj8suELRHh6dr1IlzLy
         w5KcrCk4nkQoh4/waF40L1GKpTdlecJqGULsna1rsOELInQWqyl3v8LDpSyApeBMwgmF
         NWLYcM2TaXR7ulJ16cq/ff1uLwZDTmoZeUhnAqQhOMCIHSaLl0M/wd3q1Rt6+54ooOXQ
         /7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866167; x=1734470967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1nM3RAlxJRatFMEsNUSDK4GfiwoTfrUPqBU/Vy4UE4=;
        b=Bn3HOrCUusOawMVku0CjPsrx09K90bTaHr+G5c5JkJ1zaez71DhjAtFpl2T1Gzt0n8
         vR3yM83rwH+MB2TCKQZTdfw+FVvyB0GYcXRwV6f7cMvwxlFeDDeI8eocU2D4T/qyamWI
         Tre/tJcHw8oTsAMyp6Y/I8B84x/vIV66yTSlkqklhym7i0G0bXieiaHtL1M29ZFfVZRT
         UGILdhLFHOjplAVlYoxTs8c98mg9oTLYGdeJsIHSH7gCUwlPOWWRsPR/fCSmThMYntHw
         sxfgIFEIO1iRjuv0HkqWWf4M65Zq8VLl8I5A3Kyqu/r4+e85CZa6Ec2mAXk4pxWqIO+u
         gdBw==
X-Forwarded-Encrypted: i=1; AJvYcCX2eRLmw7SjmvorCKCmfvmCr4h6Efq+zQpyNJckdFbbZcYdVzajjebT5wk8GQRIembHSk3D1N6cz9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFZ7MMT+uaCL00nvz2bUopxIoZp+te3QRUfC6bn1hVtNxBBNc
	sE/5+xQuEajDEf7jK7brD/6S+sm6ie16JN0lDQ5um3O9QrL4zTX1YHYxkq7tZZumkA0xpfofUap
	uqwOhm2PhapxXENuV6mfZr0iIgNjbgVOqXo1C
X-Gm-Gg: ASbGnctssXyWnJc/5c197rExr4NRlXEUbK5IMHYqH2ZY7hh+2NiqN+GI5CxtZW+SEZO
	bFtLu4/pfISHv9FstJX+ldCLyBhdZw82SYg==
X-Google-Smtp-Source: AGHT+IECEnPx14mb5pxVteT8GUHvp3Itx+8htdnWjvOxPn5JEd20pNHYxb4Q9WCfhZ/kfqo10RVgZLtrYSgYGxf0Jxo=
X-Received: by 2002:a05:6902:150a:b0:e39:95e8:3196 with SMTP id
 3f1490d57ef6-e3c8e67c3fbmr862132276.39.1733866166935; Tue, 10 Dec 2024
 13:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205160925.230119-1-mic@digikod.net> <20241205160925.230119-9-mic@digikod.net>
In-Reply-To: <20241205160925.230119-9-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Dec 2024 16:29:16 -0500
Message-ID: <CAHC9VhRk_9EJ0VfsUcOJfskY+dXbjsJW3U_x7ar08MK-8KKtiA@mail.gmail.com>
Subject: Re: [PATCH v22 8/8] ima: instantiate the bprm_creds_for_exec() hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Serge Hallyn <serge@hallyn.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:10=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> From: Mimi Zohar <zohar@linux.ibm.com>
>
> Like direct file execution (e.g. ./script.sh), indirect file execution
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution is optionally enforced by the interpreter.
>
> Differentiate kernel and userspace enforced integrity audit messages.
>
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Link: https://lore.kernel.org/r/20241204192514.40308-1-zohar@linux.ibm.co=
m
> Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241205160925.230119-9-mic@digikod.net
> ---
>
> I added both a Reviewed-by and a Signed-off-by because I may not be the
> committer.
>
> Changes since v21:
> * New patch cherry-picked from IMA's patch v3:
>   https://lore.kernel.org/r/67b2e94f263bf9a0099efe74cce659d6acb16fe9.came=
l@linux.ibm.com
> * Fix a typo in comment: s/execvat/execveat/ .
> ---
>  include/uapi/linux/audit.h            |  1 +
>  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
>  security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..826337905466 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -161,6 +161,7 @@
>  #define AUDIT_INTEGRITY_RULE       1805 /* policy rule */
>  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
>  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data inte=
grity */

FWIW, in the last discussion I believe Mimi preferred the name
AUDIT_INTEGRITY_USERSPACE.

https://lore.kernel.org/linux-security-module/b6dc4d8b23b822638ab6760558095=
03060c0bca2.camel@linux.ibm.com

--=20
paul-moore.com

