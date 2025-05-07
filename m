Return-Path: <linux-api+bounces-3706-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249CAAAD5DA
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 08:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4837F1B67963
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486C1F8ACA;
	Wed,  7 May 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD/NaWhu"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80304A00;
	Wed,  7 May 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598767; cv=none; b=J1f9UlIl+v6wcPieBd5sPfOGA+kGsYe1aegh5E4Vu5JwTTmkTn2BeM9fZ0wtb/7PxQ6/EXOaTMxuTGX78j2hFtdk0OOpYR/7IH7yYEi8oe9V9lyutD9VUIs4nIIE6kpYr//Y8CWdWYWj2SREzRhsFUsHhJ7T97T4bNkPxa/26xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598767; c=relaxed/simple;
	bh=8CZQqrOdr7joeny9/xFQvVzUH129BvRCXG/wovAUOOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXGfFf+6ZtkxlqbsDep+pqRJsbgpIIEIy6UaNDKMNZ7ewIvBb7+xMh9HcJMUl28lEGUVgu86utp/w7/ihdWNlmMf3M2/3QwvHfeRLH+/2ANq871hLK9LlZ30bt6fpS2B9cgYl5mlc9hSDUWqf3jXhQgfi5eg+MQtd2EU/mse+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD/NaWhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB52C4CEE9;
	Wed,  7 May 2025 06:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746598767;
	bh=8CZQqrOdr7joeny9/xFQvVzUH129BvRCXG/wovAUOOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FD/NaWhu02dmXYApR/+WamKngD3439t9klPDsIztu0Gx0jxrF8sPNCF1iYbQNkWit
	 CjnNNRZlFiJratmCc6zNAsxy/N5EcoIJM//4j2usLbNp8xy7jeLKExLqBTfhvQkVrF
	 SfB+PFl25shziK8Y1REx3tZ/c5pc8OBn6Wxxc9UL630pmyeyzkiRkWAJznHl+HClkq
	 4dmkI/B/maibSeawxO/wdrAQGMqePlp3pbWyzDzTxiZZNtELLsNYCSrgMtZxb3lvAd
	 FDSwJtOcznoq/vHg5JOpKvMaHSlubRhRIOWBxXsa5kLdAW612+wF25NpuKxP145nPj
	 x2NJKlqwBS6sg==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7cad6a4fae4so857059485a.2;
        Tue, 06 May 2025 23:19:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/+jNARiZcNZ5yJG5dYvc9SH1wUfldwz6uOPpDo15Om5rVeLdhz8SrjFxx/Y4Riwbpm2C6/q3mdZ4=@vger.kernel.org, AJvYcCVejz8KhznPKkJbz8tyFTozn8uGPa7GKVtHq06Pbwv7zzueezDvSb5idHS04UvmazoDlp1Gs85T+Er0ecPk@vger.kernel.org
X-Gm-Message-State: AOJu0YyYsdEAJgp3niGm62kqHSaPFtV+OXGwanUnX1JfvXmuK1i5jALR
	vnO387TRWG5FFW4Rc9AxkL/0xEOUDzFnvyDkc2Q2v+pPeVCCFuUjyNKP3GCmPz2ZwlCIxPtxE5X
	lLzCGjZkqrroPIOgyvyoSSX1j7Nc=
X-Google-Smtp-Source: AGHT+IFOAexx6Cca2tgkZKWixKEUI1hkSCnfEfKpmLyEPObC5f61sKXL9VUmnwJAOUKoDUXRr+P53NwPuDNndo7P+II=
X-Received: by 2002:a05:620a:f0e:b0:7c7:a524:9fe9 with SMTP id
 af79cd13be357-7caf73b65e3mr302925385a.27.1746598764695; Tue, 06 May 2025
 23:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506143254.718647-1-maxime.belair@canonical.com> <20250506143254.718647-3-maxime.belair@canonical.com>
In-Reply-To: <20250506143254.718647-3-maxime.belair@canonical.com>
From: Song Liu <song@kernel.org>
Date: Tue, 6 May 2025 23:19:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7q1hvOG7-uG2C8d_wWnOhEmvTmwnBcXZYVX-oJ8=5FJQ@mail.gmail.com>
X-Gm-Features: ATxdqUF43GzC1HJ94jSl3NM4Jlp-iA57c5ukAWNMojChQYmfJZV8PJSG5aYaZj4
Message-ID: <CAPhsuW7q1hvOG7-uG2C8d_wWnOhEmvTmwnBcXZYVX-oJ8=5FJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net, 
	kees@kernel.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:40=E2=80=AFAM Maxime B=C3=A9lair
<maxime.belair@canonical.com> wrote:
>
> Define a new LSM hook security_lsm_manage_policy and wire it into the
> lsm_manage_policy() syscall so that LSMs can register a unified interface
> for policy management. This initial, minimal implementation only supports
> the LSM_POLICY_LOAD operation to limit changes.
>
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>
[...]
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..256104e338b1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5883,6 +5883,27 @@ int security_bdev_setintegrity(struct block_device=
 *bdev,
>  }
>  EXPORT_SYMBOL(security_bdev_setintegrity);
>
> +/**
> + * security_lsm_manage_policy() - Manage the policies of LSMs
> + * @lsm_id: id of the lsm to target
> + * @op: Operation to perform (one of the LSM_POLICY_XXX values)
> + * @buf:  userspace pointer to policy data
> + * @size: size of @buf
> + * @flags: lsm policy management flags
> + *
> + * Manage the policies of a LSM. This notably allows to update them even=
 when
> + * the lsmfs is unavailable is restricted. Currently, only LSM_POLICY_LO=
AD is
> + * supported.
> + *
> + * Return: Returns 0 on success, error on failure.
> + */
> +int security_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
> +                              size_t size, u32 flags)
> +{
> +       return call_int_hook(lsm_manage_policy, lsm_id, op, buf, size, fl=
ags);

If the LSM doesn't implement this hook, sys_lsm_manage_policy will return 0
for any inputs, right? This is gonna be so confusing for users.

Thanks,
Song

