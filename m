Return-Path: <linux-api+bounces-6792-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dFeOLuNaTmrILAIAu9opvQ
	(envelope-from <linux-api+bounces-6792-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 16:12:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352187272A8
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 16:12:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=FE2vSemL;
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6792-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6792-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE5B330AE244
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B945442110;
	Wed,  8 Jul 2026 14:01:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90597442104
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 14:01:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519316; cv=pass; b=j3g3213tDgKI6kK4ILbXEkUHqEq+hw2Y9qUbmUkIMPydBz4upx1A0704cYllmUh41OIKEJzQ4g4vKXeeolRx3s6V9Z9nCEnQNkOt+XXGbnIFo7XmjDHVKKAxjP6Fot9vDKGhg8Ob4akByMY2jWGzxVRFMI6pQX+ziZzim8WhzSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519316; c=relaxed/simple;
	bh=+K/PolHf20ghWCB0E8aQv5OnAwl4AIEKdX7utssQh+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA6IoOvgcZUe1o/QnaMVhBZfAjGDYmgjdaR8iErZ7RXwMUhWY7hK5kvi75HJNxkZKO9GKgEfnU6CP4Rxp6GWTS4CRjzhSDO0HaX38nt8qnX6SVFzkYM3Vowy97N98yDVAJnHUY5MVznNjv129UR0c2XP2obvi9/9JM0VYiu/LFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FE2vSemL; arc=pass smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5cb052edso50516185a.2
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 07:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519312; cv=none;
        d=google.com; s=arc-20260327;
        b=kwaDB64FwKPE2p3vni+gPIM83y2j4PK2Aex98Bjn92N1MwAwjRPED/BQFLd2dxN4cr
         AoIwOK3uT7ogNwHM85nBiDWOf9pOPJBQj070ve+mgUQRP8+Az8ONDeRBcQhKWkyekqoG
         DtnWT3Ag5AekdnU/HVo0MmFV2nIGwTR7LzoVvjNFTIZfqsF5rWQJwVIYN/zZbp/OS+NV
         tL+HMl0g+9YbumhgcM0sTAqkHZILB2SwmFwRrKfub1etLIj6GFfCCgaoK42DGbuqQZEM
         lN4yZ62eU/pPVZuPl0W92ptfh7hH54bhnV6MM045+Obu4enw/Wx5DGjYrTVrUdocFhw0
         IITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWkMP6ENo0m0i33Nu6yUk0oefbASMwJB/eCX2aKtZUw=;
        fh=3J7epXaI6nh8rzbbXJ7LcfYI4i1HPSlFhBElfmEcj08=;
        b=q6hD8GMQfmP9yS34lfuXUtqBbO0tsUXWg+VHixB52O2QsVwQ+xkxR8vNjDuP9rv/OU
         6UsVFU4sr5y77Wpm3/JCsyoZdkXK4pYVj1PJxAbzPyL3OzsbXDDBJZDud0dmkIQUFqsr
         6fJp1tfjuzmdUvU6QOurLj1LPYgKcsmzGfZATgg7v0/80y2sd3d9X/sSjHs2pFKeF/0d
         /w8EFUtEUpWHTp6650yMUFybrmtLnSWSEAxng5y7/Bj25MXdp9sxs+/uA6HSMq5QlNTw
         ywS7yvkuevPinGFzSTR7kphMxVv/AytrwgwXIE+man5qMmxnSIxYQLsp2sb7RcCw9c3V
         smnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783519312; x=1784124112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vWkMP6ENo0m0i33Nu6yUk0oefbASMwJB/eCX2aKtZUw=;
        b=FE2vSemLBR4DA2u3DKo6sacRgKuvHvkma6XfKcwJXzklAe1ek9iqdilGqwArjhLmO6
         NfUwhi9buKzf3KcIXJNhaoIipQ/Q//VznO1yHOG2GwWTkpoB1vXxN33U8GwStJMknial
         GV5fNfjwGNotd8h14zqhvEISgWggwevQHua/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519312; x=1784124112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWkMP6ENo0m0i33Nu6yUk0oefbASMwJB/eCX2aKtZUw=;
        b=hsoZik6jOH8dzFTpCD+bckfDF3pPEr5XXaLzf+aDeEOdZodFyBEiQc9IE5aFM6xykA
         hWk+CRQgxiR9xEfnEIYJIotsQsWyj3SiatBbpYeZCG3BgZbOVEH48lDjxFSQwwiBLlqV
         b7zXZc/47PQ+GIEj2PEDK9zasxX0/knaX1GRwiR414Xc98g0wGVfRvr6D+vRmK4LgpN8
         2flhRN5Z++apsLtBvMs5hcsQF4lJW1NjhhWO6WK0GsKHww6RR9I4pn6W4PjrOkWuBiyW
         a82WkkOlPTzxVQr92vSpremWizNcxZv/tpPzHx7+o9f7B2CPSqBuo67NbK+D5LjEJNL9
         Z2jQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8J51V4nUzWttGw7s4M+3SEGpaflvD6/gh1XfjwnZb1WjiyFV0CwQVwDtM9/ZXKSVskDEGxiaMtxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOk3c9ingRstWXbDoRvCshFQ2cfbRibgnthc4PqBPa9AVmA2s
	nTR4W/SjaokDYWnnKKfIkFZnf3j1Q5hH5RS/+T21RfpEmw3vzUqs27SdHsayeLWasWkQRKBCmhH
	bMPK/YTgcOarv640aMmdNE5iZ4T3514UieCGYX/T1Gw==
X-Gm-Gg: AfdE7clDz3SEIbARsqMZTkTLXSO4rgm4bYAQ3iW80wHKjTDU5ctYfKT+HVYfOjWNWJt
	zyKpFC6MZ+t9WBX2+uc79dRwkRBZt0NHnr4aAvep8g93OjAhsxXYlqsVVQOV1xoyTgdsWDNak0f
	QdePnwnWGD2Ac77JqZmSwQMZoYLVbNEs+mHmZXruCEnBFJUQvfSRhQP57A7yCgH6xtnlAyFPgFZ
	jSDvIn6KnwWk+DwctsB2zuHpWMfS0hCDVgebsbAl3ZJrJ8HUFduvibWdstn1FaOAUSdwyb5vaf2
	3cQfhoe56Zrz1n1Rpj5zcyx48nJxahoVROVTTg==
X-Received: by 2002:a05:622a:134d:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-51c8b3993eamr26471751cf.3.1783519312028; Wed, 08 Jul 2026
 07:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAOQ4uxiiVsp0BsdqfH3rCrpP6fBi-vTyfXd-TcVmFcS34MxzUQ@mail.gmail.com>
 <871pdd8ukx.fsf@redhat.com>
In-Reply-To: <871pdd8ukx.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 16:01:38 +0200
X-Gm-Features: AVVi8CcKoJxcOuex25eFuQjNrcac3g1KeS0qxI4UBoIPpSpnnYXfivqBUUnrS0I
Message-ID: <CAJfpegvtd--TEQP9CVjSZuosU4meELdzhTV9oFo6joR1f4Dpgw@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6792-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:amir73il@gmail.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 352187272A8

On Wed, 8 Jul 2026 at 15:44, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Wed, Jul 8, 2026 at 2:31=E2=80=AFPM Giuseppe Scrivano <gscrivan@redh=
at.com> wrote:
> >>
> >> Miklos Szeredi <miklos@szeredi.hu> writes:
> >>
> >> > On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com>=
 wrote:
> >> >>
> >> >> Add two ioctls to overlay filesystem to allow userspace to retrieve
> >> >> information about the overlay layers:
> >> >>
> >> >> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
> >> >>                         arg =3D=3D 0 returns the upper layer (-ENOE=
NT if
> >> >>                         no upper is configured), arg >=3D 1 returns
> >> >>                         lower layers (-ENOENT if index is out of
> >> >>                         range).
> >> >
> >> > We could do this with a plain open() call.  Something like the magic
> >> > symlinks we have under /proc/PID/fd/.   Question is where could thes=
e
> >> > live...
> >>
> >> is there any existing user of such a mechanism?  I don't see any mount
> >> specific info under /proc or /sys.
> >>
> >> >
> >> >> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
> >> >>                         with numlower, numlowerdata, and has_upper.
> >> >
> >> > Isn't this info obtainable via statmount(2) already?  If not, it
> >> > should be there, instead of a specialized ioctl.
> >>
> >> no that is not exposed by statmount and I don't see any way to export
> >> file system specific data through it.  Do you've anything in mind?
> >>
> >> >> --- a/fs/overlayfs/ovl_entry.h
> >> >> +++ b/fs/overlayfs/ovl_entry.h
> >> >> @@ -35,6 +35,8 @@ struct ovl_layer {
> >> >>         struct vfsmount *mnt;
> >> >>         /* Trap in ovl inode cache */
> >> >>         struct inode *trap;
> >> >> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_L=
AYER */
> >> >> +       struct file *origin;
> >> >
> >> > Don't need to keep the file open: the only info missing is the
> >> > original vfsmount, everything else is already there to reconstruct t=
he
> >> > file.
> >>
> >> I didn't manage to get that to work.  As soon as the userspace process
> >> closes the mount fd that was passed to fsconfig, the anonymous mount
> >> namespace is destroyed and dissolve_on_fput sets mnt->mnt_ns to NULL.
> >>
> >> So whenever I try to use this mount again from userspace, it is not
> >> usable because the mount namespace is empty, causing check_mnt() to
> >> fail.
> >>
> >> Do you have any suggestions on how to solve this problem?
> >
> > The suggestion was to store origin->f_path->mnt instead of storing orig=
in file,
> > because you only end up using the origin vfsmount.
>
> the reason I am keeping the file and not just the vfsmount is that the
> file is what keeps the mount namespace alive (preventing
> dissolve_on_fput from fire).
>
> Should we export open_detached_copy from fs/namespace.c?  I've not
> tested it, but it might work.  Are there other ways to solve it that I
> am not seeing?

Using an anon namespace sounds good to me, that means the original
vfsmount isn't needed at all.

Not sure if it's okay for the case where the original ns is not anon,
but we can save the vfsmount in that case if it turns out to be a
problem.

Thanks,
Miklos

