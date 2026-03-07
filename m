Return-Path: <linux-api+bounces-5909-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJzaBel0rGlCpwEAu9opvQ
	(envelope-from <linux-api+bounces-5909-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 07 Mar 2026 19:56:41 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE422D4A4
	for <lists+linux-api@lfdr.de>; Sat, 07 Mar 2026 19:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC8523008CAB
	for <lists+linux-api@lfdr.de>; Sat,  7 Mar 2026 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4F39150B;
	Sat,  7 Mar 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="UERqbxJK"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746B292B44
	for <linux-api@vger.kernel.org>; Sat,  7 Mar 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909795; cv=pass; b=iuCE61FEVcElT1Oj/+PlHqP4xQCZPcoDtJmjYoc9/GsNTS83Ui/5TO0rD/u6zMaDm4QZfO+mlyQsoZg9l/StExNV7/ctjblsWhK+S9ITQYND/OBLtdYurqCddqG57Lj9b1PJOcJ9I2W3GvNHlqr+LaRkDzjZNi11QKOwYwzQ9J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909795; c=relaxed/simple;
	bh=ipPnoEwRKGay/Kqh3e72TxDAS0WvWm5QHtGzwkgIhmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKfRkZXV6oS/+Uy8RjTrxUpHNCJZGe43UU6yOBVRZWuZhWl8yzi4IjoCqeEnQqK7Rjrcxwt1rR/R6WjwFp3GIgMOarOyvzlyz+KF0vxI9CpD0AT+pveqgshJxduD6jobE0Lcp8ws+T91GJKoI650NoP9T124pR1Zm9K2Lx4S0qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=UERqbxJK; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a12c19affeso3643725e87.1
        for <linux-api@vger.kernel.org>; Sat, 07 Mar 2026 10:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772909792; cv=none;
        d=google.com; s=arc-20240605;
        b=B6JtAOyK3x8huoSF89lIA+rbR3debAyRBAMSMp/Bbgp9ENmaLcH/sFd/Y+yxkBBGeG
         5I3OI9br6bgTy89p6cIYZPCoUOw8mIFQ7oaozMQ0tMeC0xWK4Nu3yAjWe/2XPWb5oLVl
         782g13+0C+nhj5A/686R+eiwpEqk5QbeK5JZ99HUlthivtv0A9MKo6n1B+B6Msx/j6K/
         G3ceD+jgTIK0tPmu3yJsqJ420Vb+soZI0mmHDW7JfWyMnOC7QeD2n70IBz8uPwlEnXdK
         sN6QFOaVQcs+YYaq8OXHEYOuNdAU1p+3k1MS1jXe3j50bGmc1dXhfsaw6xLPOXOmmYhg
         E7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        fh=IHomm6jAeH+lUGJKD3PnvKsBwB2oLfwAmH0AqbGStrM=;
        b=kRbkEm4RIq2yi5fJ90oItkAIEiZhPVZOBK6U/YMZyLUbbHaBKJtZHCOnGcByI9BHl/
         GRzpL/J+3JhQuoL3/lEsuTRKKnGzcla3SZN/wExf0iq19hola1PO6tjhiswO5urgW6mb
         HEjMPjjR0Azkf9Tc3UA0l/cvD6amtPgKtMc9Tr65jeUfVYWiWZKfoLb3Xppd7SdilouX
         64eBml3p2fD5q6hnNKf0fCry4DMPm3xLQLM3YbLfiLurRAOvOQUMMPi4W0j3ZTUOnDL3
         NuUWYl+bmUsnXo80X9pnal4XrX7URZDGnkupoxmXC2F38xg7qhre0TDnGHzbaYaVsDez
         LsFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772909792; x=1773514592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=UERqbxJKZngkPO2K4yr5YwAFzKHDjj8r0w4oJuzjCO0kMIqLOi33dFigOAK5fZJwBg
         t3vBGotLKf2C2GyPcVqTqi/0bMqWfMRpqQ5rii8Lnt1DIjrG4hklubdBbb0zBjvmrxfm
         0ACUWOD8gJuwgtD1IRPU5MEQjhc5r6adr2y3vMIGiLtTdq4ZL/+TuRATJssUP64XLQ8k
         697wEJo9Gi1YFv8vDxzYYf+i++1UCLQBSHd5HunMVb0RrP2RWyiZRuwnSv/rA/6wMP/v
         6PdybPK88LnePRQ5doBRC2ZH8V1L7CaJDdTOdndxaW4gM9uvjOm57BKxPOmZpQyF5BOo
         dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909792; x=1773514592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxUV6l0cXcVJnfGWc1SwZOsz+kJgjCkHV5Xd2O+xjBY=;
        b=kncvNfzF0JlRjX6pfhG7Q6RzV/0ytCMuOu4pNdNrvrUnS1SYVQBTxL0wWS4xo8CazZ
         Tb8ZIgcMp5qAcL2IDWMiYuVa40a2/6koDUqn4uTA9fjQty579Bp/jIF5qpAk2CgxWr4e
         nAc0bBmpBScFridCB5N8ifAcOONvtAAWIrb0FG/ZSah7PJ/Oyr52bMIhnqDEWDVpA9jW
         ZgkxBbY3Z/BiFjldBcclGSzkuLj8QBC1lRmwXcyh/8dN3BB4B5scEiYw+MnEH57Dc0hs
         C8nqn6COGaC9Zh8f7x4DSJ0NlhArmko8emqUqwS+bsLFQIz2oDDKL7yl/KkGm9C20wND
         EAVg==
X-Forwarded-Encrypted: i=1; AJvYcCV24sgE66B4JNpm6Gm3uCNy2l8Yd8LjLsVz3MuvG89ONBSdISZHrelS21P4pbzxYvFRlW9dsCP3d0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxeNXg7zC64t7+yBZAhOZtaWfsUyoTDRpQeW5f+32jefSBy+u
	l19HGUfBFGtpfmR520cfgifjULgKN+iqPpqBy3UMBoXzvmHe0Ach+zstPXYPJ5SjBU1IYE5Dwbx
	ExuI7b5zYW9Lz5jp/tYnhkJVKdSvS2u4kXNBipVoO
X-Gm-Gg: ATEYQzyQ9caz2heu8jUYtYJ2kL6+8qymf8wEUbI8Pyw2jIcQGl8Vm7O4u/+WshN1Rk+
	Cl894PDYf2hqVkZ7zjsYiJaE4BxQpakkdG1urigueeCtz2sU8zu8jB/B8f9A+ACcpiWINhzTFc5
	h0jC5XJxjfRvQjp4LceaXz18/YyFTayyerdNiOu6Ie32Sn1gjE9Y+/3SsYa3tsE3Z4T/GqcLXWN
	2N5SG1mJazVepPIMg0330EJuIKaxlKYf/DvsfnD8KNSrt1hisYdnoIpveyqsGbZH5ge98KEg4z6
	gF2wv7zR
X-Received: by 2002:ac2:5694:0:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a13c93d9e3mr2016793e87.18.1772909791880; Sat, 07 Mar 2026
 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com> <20260307140726.70219-2-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-2-dorjoychy111@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Mar 2026 10:56:19 -0800
X-Gm-Features: AaiRm51B7g_JMhlZIdflpWCsx5DmxAmpibsspywnWIGz_sEa1ctulidKDYlHz5s
Message-ID: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0FFE422D4A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[amacapital.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5909-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>

I think this needs a lot more clarification as to what "regular"
means.  If it's literally

> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.

I think this needs more clarification as to what "regular" means,
since S_IFREG may not be sufficient.  The UAPI group page says:

Use-Case: this would be very useful to write secure programs that want
to avoid being tricked into opening device nodes with special
semantics while thinking they operate on regular files. This is
particularly relevant as many device nodes (or even FIFOs) come with
blocking I/O (or even blocking open()!) by default, which is not
expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Cons=
ider
implementation of a naive web browser which is pointed to
file://dev/zero, not expecting an endless amount of data to read.

What about procfs?  What about sysfs?  What about /proc/self/fd/17
where that fd is a memfd?  What about files backed by non-"fast" disk
I/O like something on a flaky USB stick or a network mount or FUSE?

Are we concerned about blocking open?  (open blocks as a matter of
course.)  Are we concerned about open having strange side effects?
Are we concerned about write having strange side effects?  Are we
concerned about cases where opening the file as root results in
elevated privilege beyond merely gaining the ability to write to that
specific path on an ordinary filesystem?

--Andy

