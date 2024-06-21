Return-Path: <linux-api+bounces-1780-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B4912AE2
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 18:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303B7282EB0
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453115FA84;
	Fri, 21 Jun 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qXSVxcs+"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A5156C47
	for <linux-api@vger.kernel.org>; Fri, 21 Jun 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986022; cv=none; b=Eko6JCmwNswA8qg2LVj3n+XR9qwZLXklC6gmKLeLQjWhx13E/7Ju0/hYagpajNPrgI6VHCNSHgGBViv905h4s1tSIEFDuIQYsn4BaCNQmkuDfcwQdgXRC4p9rGvG2FHTV94yuLpUZmJK5pDPDht54cEO4mIKs86qvgPmacZd2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986022; c=relaxed/simple;
	bh=4JXEbivYBcsxYTgIWZVnh5SdG3somsUbAFEAVWYGAQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F5ac567Y1Gtd30Idi8cb/g4sXPy/VQNVluEoMZmrLOWnNVLgknutiZZ+xSLZwWjAtGQchlAp2/mi4TZEUQuyG4pSVMjZ2Q0OseyAu5x6m1IY7ZIkA6vQzRrHpPR7qCVt5uEz0uTAsJhhXnodue23y85hyrn0D+Ng4o9EHy5ERDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qXSVxcs+; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718986018; bh=OUlshDAGcf4r9tpcl9XAZhSVZg2AM0tLoTIMQEFIi2o=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=qXSVxcs+GtEjbZ0d5k+4l2SAnxGZ90p8r7pSM+sPQh0gwiWK7oGOPt5A/djfgiWq3axN8FuWsOFcEd4VoiiaLQjnrZnE4KpF0HL3p4wcQEQVLCfR//kRrNPfMqeWmQ6UnqotKJJguw532wrh9Htx/3jxi0q1bNTIx9oOVTzal8v3Y46/Sp7Dmwct4LWKvmvBYPp8H4P53BoRpBRCZdFn7YAHCAjTjOqhMXYkS/3XL0UlEm648T/Wa2QxsDyguB2hpqCTlQiiAHDKG+iQ3tj4lmX0SlcPy4XxfQuCy0nv4ohAkCMZeKFwE7YiSNFUZYpcL4BkZJ4JLKPeSepJJkngYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718986018; bh=UhRdylbyR4htXfQ3ksARAjZ+RHaqucn3VSCr8yka/PI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=k5vdivu9A40A7njFYrRvHuSrHcq6MDFQ4uOP6lf2zpAcGjgw7pbMhMkq/HUOtB5VS8MnXBXxMRID1MmG1I/ovptzCojf3kq7Ezuyl/J7Znr59053iXGSIuLhlwgnBzjK6uSvzWP+rdq+0rQK4qcdEtV+eYvWjVkAQ3ZE21tUIhHh3CLGjdiQflS60u3lhE0P+rmdun1cnfbZ3zV48B/YSTwtfnX011aBu0YPsPBI5q42CI9YZkBph6y5tmuK+9R63bQeKz5HFlsZHdKmCPk72Xu7lDSYVuIscWiHynOig52r4A8UCxB3ntfSlXFiPQQShdGWW8ekfDG1PMSpJPhztQ==
X-YMail-OSG: UOgmaHYVM1l.B2Lrwvs9KpB9HMayDYjTI.v_pcGE.wyV8yJdV__a0iUF6w8M_ZQ
 9DjlRcCmrDJAhwYa_DkAW._pe1YFEAdBPbisx6IBljY6jPDBVytM15A3b9y_ICOOf6Y2gQyZZQEG
 vbd2Ra5Z5dETlmzIeIem5nfBDxGPXM1pS9AQQLiG8TTrc9bp1D8vFoxjewkEv.hgn.vFmLHmFiOk
 F690WplsukRvEIs6ORdxhnao6.LAE601yD5uRlvFI0F2xivoOQxcfl7IkyeelamXEfWJXhJqi0mt
 m5X6mp56a_Gh3YoMT2OP.MUPl5qWpfqu_pvLuaYwF4QfB87ApZ7_J3Q7AQJPNoMwqcS6y7Ns2dge
 9i3gRXrET3MvwMizhVvjrhr05YyzZqyypfOdvxvWi5fNLqHE8vLbTqWHjC3LPIinledP0Oizg8iC
 ej3v0aVoGCou.qFqoLnLLKEzpkrVPxC1g826XwPCOLCde4QgW1JcNCAO0Lm7S7DnqJUgI7AeQsir
 .E3QINU30eyLN27Xw_crEpXNJaGkBuGXMPMebwXz7T2yVOgXBVarAoLG9EjeO.icxB.4Km9yQi4r
 _SieKbYMH1vuLQxciuDMp_O7_Jo.hodJyD8LlL9JPw38l43TUDCTvJpsSL7hy9s036PLrBveClYF
 eDbEtIVfEb4YJTf9ElyIrvYOKiNDU61pA4waE0vaA.a6036kUAQi4rjqszjaEG73uKevvXLuut9U
 RSbOb6PAMSdPFZI9nu2SzqKUTs7gDFAWYcekbebo_fbyy6Rb4ryZkDLaUEM.pRYDBYihY6tCnEjP
 mcbJ0v21C1a4JlKj6h6.ts6rWqiXZDU7OHKxyAmK9pT.E0iYVloph6MPEUEwwHnOJf08eZUHvcWB
 ON._nTJNBbw10Je5FWqkz77Ca8_2kgcBTrSkCsmzeziJpPTpqIKZMLSD9rh67uIqajVByCXKKcFp
 5xeHHXNHYLdWiZMhyi2C3lFunwBdK6JQPqLq62hA0D9PwH19C1QSTGg1J7OZehcMEYkrvKm35Cey
 6GlqyiC7W2AT0a5bGyotkT6hrwpyyUuINqiYBcC1zWbpqoZXi3Eom_jNBVTpwvwJfPopb2QNoOJ8
 64qDnw2fj93bG9Lc27MP9W6MKLW3QpRe8HcX6GOC._NfQthkrcwjkgTLHfPGWEKCChwlRvqgBSNY
 b_qOYv_tqcePaCCtN.tus.xdI7qVNoGRS_LcqH3hqbGf1oBzQXDIc1sgypqGoCs62Vr1a0F2YEf1
 MX3DjJH6pp2jarQG2BgP1jrHWzNyCdwHPZdwA7zM9NKn5T8BW18OwsAm7ziVT1vebnbkW_hlmXFx
 lA9ERpKKBEB7AYpH2B2.343nl2pJ7jnrLGV3hCkf4i6J8Q0TRF68_lfwSQ0a1lglJsDxXC_qPmXd
 BQuc0YZ79q2QNaUvSYM.aCsKnovkTLoXfuGhYX_.fIktvZYhSkydkUZc56t1F1PAuCb4rC2jGkjp
 rpngP_51S0IuaTBR5XtdzSzVupHco63RcaAS0Zu3iGqf8s24Ku4mdnAATcX1BtEvohK0dIxPuEos
 oitPQJMCvG_BN4pZSQDGuyhVAeYm.GM1fLquHub6fQrb4wvqIssazbb58JiN.NUU2ESj1.RGllLx
 z1IOcg_QAymfklby7q8FFoOZ_fRuL38bHX95Vfhxc6jbcQpr9akYcAq76U4dPRrevo7zalZ0xgdN
 rMYxWlGZvQfuhRBvZbIGgAhPxQwqnMjJd9N9SWpC93I9g1S5QAWQvYCR48IdbRZRWNZJETdn76AK
 pThh8UpEzWYOxyaxKVPfDzIPm92kp_lUyxV4Sb_QpFrLsYqrYRbYvcMjg6HDAP7DC1YEs811wqad
 ayFe7IrbomLVkvRjQskGjt65kVsBUd3alLX6iNZ_aUA48kmGeKlF5jUw0iatgnj358cIaarUO7dC
 YUwZawNqdEQyEdFmqagmEoCCIjSdL9q2Na8c7Lg0fmDEUYo4yt606buaBldxbgivtrlQbq1.hdbR
 f_5IFiDe66qpM9V1PoWMwKKgcHNGHYBIrx_6m2bfiBKZ.QtA5tUnk.UI_ejS4Q3rFyiMwqKl9vji
 eAPYIl1sRp4Javo.3VcYbK1N82X1vfOUJ4gR9ovSbF4TDICFRC5qbgyoLKvwwHWuk5WrgbJ2nxAw
 2gKVpMPJW70ZUXk_ZeRrzcExGs11R5z6s9SSOimuV0UIwXSGTVqKh5pMN6.kaYV8O6iaBejXCMK8
 G3i3Cjsw2qH1R5rpPQF4n7h6WTVs0EZfhJjG.1s8kSan7AdOlq_Xtt42lX6y2STwOtAWH
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 63602443-7919-45b5-95cb-a0501af045f3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2024 16:06:58 +0000
Received: by hermes--production-gq1-5b4c49485c-4rmzt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a6ae495510b30a623b4b0801ff5ab356;
          Fri, 21 Jun 2024 16:06:55 +0000 (UTC)
Message-ID: <c59a4954-913b-4672-b502-21aa683d7cdb@schaufler-ca.com>
Date: Fri, 21 Jun 2024 09:06:53 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] LSM, net: Add SO_PEERCONTEXT for peer LSM data
To: Paul Moore <paul@paul-moore.com>,
 LSM List <linux-security-module@vger.kernel.org>, netdev@vger.kernel.org,
 linux-api@vger.kernel.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>
 <83ef6981a29c441b58b525e9292c866a@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <83ef6981a29c441b58b525e9292c866a@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/20/2024 2:05 PM, Paul Moore wrote:
> On May 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> We recently introduced system calls to access process attributes that
>> are used by Linux Security Modules (LSM). An important aspect of these
>> system calls is that they provide the LSM attribute data in a format
>> that identifies the LSM to which the data applies. Another aspect is that
>> it can be used to provide multiple instances of the attribute for the
>> case where more than one LSM supplies the attribute.
>>
>> We wish to take advantage of this format for data about network peers.
>> The existing mechanism, SO_PEERSEC, provides peer security data as a
>> text string. This is sufficient when the LSM providing the information
>> is known by the user of SO_PEERSEC, and there is only one LSM providing
>> the information. It fails, however, if the user does not know which
>> LSM is providing the information.
>>
>> Discussions about extending SO_PEERSEC to accomodate either the new
> Spelling nitpick -> "accommodate" :)

Thanks.

>> format or some other encoding scheme invariably lead to the conclusion
>> that doing so would lead to tears. Hence, we introduce SO_PEERCONTEXT
>> which uses the same API data as the LSM system calls.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  arch/alpha/include/uapi/asm/socket.h  |  1 +
>>  arch/mips/include/uapi/asm/socket.h   |  1 +
>>  arch/parisc/include/uapi/asm/socket.h |  1 +
>>  arch/sparc/include/uapi/asm/socket.h  |  1 +
>>  include/linux/lsm_hook_defs.h         |  2 +
>>  include/linux/security.h              | 18 ++++++++
>>  include/uapi/asm-generic/socket.h     |  1 +
>>  net/core/sock.c                       |  4 ++
>>  security/apparmor/lsm.c               | 39 ++++++++++++++++
>>  security/security.c                   | 86 +++++++++++++++++++++++++++++++++++
>>  security/selinux/hooks.c              | 35 ++++++++++++++
>>  security/smack/smack_lsm.c            | 25 ++++++++++
>>  12 files changed, 214 insertions(+)
> ..
>
>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>> index 8ce8a39a1e5f..e0166ff53670 100644
>> --- a/include/uapi/asm-generic/socket.h
>> +++ b/include/uapi/asm-generic/socket.h
>> @@ -134,6 +134,7 @@
>>  
>>  #define SO_PASSPIDFD		76
>>  #define SO_PEERPIDFD		77
>> +#define SO_PEERCONTEXT		78
> Bikeshed time ... how about SO_PEERLSMCTX since we are returning a
> lsm_ctx struct?

Sure.


>> diff --git a/security/security.c b/security/security.c
>> index e387614cb054..fd4919c28e8f 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -874,6 +874,64 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>>  	return rc;
>>  }
>>  
>> +/**
>> + * lsm_fill_socket_ctx - Fill a socket lsm_ctx structure
>> + * @optval: a socket LSM context to be filled
>> + * @optlen: uctx size
> "@optlen: @optval size"

Thank you.


>> + * @val: the new LSM context value
>> + * @val_len: the size of the new LSM context value
>> + * @id: LSM id
>> + * @flags: LSM defined flags
>> + *
>> + * Fill all of the fields in a lsm_ctx structure.  If @optval is NULL
>> + * simply calculate the required size to output via @optlen and return
>> + * success.
>> + *
>> + * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
>> + * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
>> + */
>> +int lsm_fill_socket_ctx(sockptr_t optval, sockptr_t optlen, void *val,
>> +			size_t val_len, u64 id, u64 flags)
>> +{
>> +	struct lsm_ctx *nctx = NULL;
>> +	unsigned int nctx_len;
>> +	int loptlen;
> u32?

Probably. I'll revise in line with your comment below.

>> +	int rc = 0;
>> +
>> +	if (copy_from_sockptr(&loptlen, optlen, sizeof(int)))
>> +		return -EFAULT;
> It seems the current guidance prefers copy_safe_from_sockptr(), see
> the note in include/linux/sockptr.h.

Always a good idea to follow guidance.

>> +	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
>> +	if (nctx_len > loptlen && !sockptr_is_null(optval))
>> +		rc = -E2BIG;
> Why do we care if @optval is NULL or not?  We are in a -E2BIG state,
> we're not copying anything into @optval anyway.  In fact, why are we
> doing the @rc check below?  Do it here like we do in lsm_fill_user_ctx().
>
>   if (nctx_len > loptlen) {
>     rc = -E2BIG;
>     goto out;
>   }

That's a bit sloppy on my part. I'll clean it up.


>> +	/* no buffer - return success/0 and set @uctx_len to the req size */
> "... set @opt_len ... "

Yes.

>> +	if (sockptr_is_null(optval) || rc)
>> +		goto out;
> Do the @rc check above, not here.
>
>> +	nctx = kzalloc(nctx_len, GFP_KERNEL);
>> +	if (!nctx) {
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +	nctx->id = id;
>> +	nctx->flags = flags;
>> +	nctx->len = nctx_len;
>> +	nctx->ctx_len = val_len;
>> +	memcpy(nctx->ctx, val, val_len);
>> +
>> +	if (copy_to_sockptr(optval, nctx, nctx_len))
>> +		rc = -EFAULT;
> This is always going to copy to the start of @optval which means we
> are going to keep overwriting previous values in the multi-LSM case.

The multiple LSM case isn't handled in this version. I don't want this
patch to depend on multiple LSM support.

> I think we likely want copy_to_sockptr_offset(), or similar.  See my
> comment in security_socket_getpeerctx_stream().
>
>> +	kfree(nctx);
>> +out:
>> +	if (copy_to_sockptr(optlen, &nctx_len, sizeof(int)))
>> +		rc = -EFAULT;
>> +
>> +	return rc;
>> +}
>> +
>> +
>>  /*
>>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>>   * can be accessed with:
>> @@ -4743,6 +4801,34 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>>  	return LSM_RET_DEFAULT(socket_getpeersec_stream);
>>  }
>>  
>> +/**
>> + * security_socket_getpeerctx_stream() - Get the remote peer label
>> + * @sock: socket
>> + * @optval: destination buffer
>> + * @optlen: size of peer label copied into the buffer
>> + * @len: maximum size of the destination buffer
>> + *
>> + * This hook allows the security module to provide peer socket security state
>> + * for unix or connected tcp sockets to userspace via getsockopt
>> + * SO_GETPEERCONTEXT.  For tcp sockets this can be meaningful if the socket
>> + * is associated with an ipsec SA.
>> + *
>> + * Return: Returns 0 if all is well, otherwise, typical getsockopt return
>> + *         values.
>> + */
>> +int security_socket_getpeerctx_stream(struct socket *sock, sockptr_t optval,
>> +				      sockptr_t optlen, unsigned int len)
>> +{
>> +	struct security_hook_list *hp;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeerctx_stream,
>> +			     list)
>> +		return hp->hook.socket_getpeerctx_stream(sock, optval, optlen,
>> +							 len);
>> +
>> +	return LSM_RET_DEFAULT(socket_getpeerctx_stream);
>> +}
> Don't we need the same magic that we have in security_getselfattr() to
> handle the multi-LSM case?

Yes. I would like to move this ahead independently of the multi-LSM support.
Putting the multi-LSM magic in is unnecessary and rather pointless until then.

> --
> paul-moore.com

Thank you for the review. Expect v2 before very long.


