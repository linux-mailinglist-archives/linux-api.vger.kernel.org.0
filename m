Return-Path: <linux-api+bounces-6050-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPg/NtAyzGmwRAYAu9opvQ
	(envelope-from <linux-api+bounces-6050-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 22:47:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C13713EF
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 22:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016A130579E6
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12F450901;
	Tue, 31 Mar 2026 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iEciUOTL"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2738A709;
	Tue, 31 Mar 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989871; cv=none; b=pUNSbjwY9zUN/TpZ3n+fDvzMeDhXN/7eocoL7sxyaDdsx3g52mBRilV6l+5efeiY2NhBiHMYev/XPnnqVhupsSTOvwQeFaMSV4OwOxchuK/Y1FOLh0KFznT3E8XRv59PylCRbU8Slv71+FilQLSf6Pdpi1shreUtuHN1JUwBoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989871; c=relaxed/simple;
	bh=y983+/rjkzf6M53UM1IDDXq0eYkSrQwapz5bFCkeWJU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cKHjMwpXU87p0HFD3P6PNK6zdSbJqFM63CS4b03HocGkcsoaM2q3lg4/UnLyW2fWLAnW+oPduS5sbfZJYPB+WQ1unbuz54hItGlgxk+6LWmjijrnADrzphqt0NxIKGV2ejOvDjVE3LsuEvRJwCOrFcZHAeoXKoKpabxSiQAbWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=iEciUOTL; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 62VKh4FL755405
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 31 Mar 2026 13:43:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 62VKh4FL755405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026032601; t=1774989786;
	bh=V0/g33lgizl2oNCDPM0m5RDMcESYn9Y1acfjoIK2Gh0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iEciUOTL4ETUqQQo6wr5ofRzrfEOfRyTMLcRqbW8kB7ua8qvmOLjTwd+MnFLUMMAj
	 9Yj2BKa3F1A6M+1e/cPaQQmSZqFwWLAMJ6g1QPg453Wzu/dYiF7ZymiJLu2c+enFQ4
	 1ByItX+dqt/V8rOF9S1y4fYF8Phwon9UVj2NvQsWA04KYdp97aWjdGNxPQYZMxZuZw
	 WlKQzHIDXIw0an/WBiuaFXtxsLscM7vTrlvDFN8V14b/474JJUB8Wp9VgiK4GUmNIE
	 an3dyDvlC3yhcqy3oC5rHfpCrX6HmhjdPoVEhyaeYpzVLuqLlSWCW7LG4EGaZFp87i
	 qJdtolklv5Wgg==
Date: Tue, 31 Mar 2026 13:42:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Yann Droneaud <yann@droneaud.fr>, Jori Koolstra <jkoolstra@xs4all.nl>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Alexander Aring <alex.aring@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
        Andrey Albershteyn <aalbersh@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        cmirabil@redhat.com, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
User-Agent: K-9 Mail for Android
In-Reply-To: <df5a6fec-ca67-4196-9e7b-cd129c79578e@droneaud.fr>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl> <20260331172011.3512876-2-jkoolstra@xs4all.nl> <df5a6fec-ca67-4196-9e7b-cd129c79578e@droneaud.fr>
Message-ID: <6BF21DE6-F88D-4E59-91BE-568C67ABAE89@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026032601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6050-lists,linux-api=lfdr.de];
	FREEMAIL_TO(0.00)[droneaud.fr,xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,zytor.com:dkim,zytor.com:mid,droneaud.fr:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 869C13713EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On March 31, 2026 1:25:03 PM PDT, Yann Droneaud <yann@droneaud=2Efr> wrote:
>Hi,
>
>Le 31/03/2026 =C3=A0 19:19, Jori Koolstra a =C3=A9crit=C2=A0:
>> Currently there is no way to race-freely create and open a directory=2E
>> For regular files we have open(O_CREAT) for creating a new file inode,
>> and returning a pinning fd to it=2E The lack of such functionality for
>> directories means that when populating a directory tree there's always
>> a race involved: the inodes first need to be created, and then opened
>> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/=2E=
=2E=2E,
>> but in the time window between the creation and the opening they might
>> be replaced by something else=2E
>>=20
>> Addressing this race without proper APIs is possible (by immediately
>> fstat()ing what was opened, to verify that it has the right inode type)=
,
>> but difficult to get right=2E Hence, mkdirat_fd() that creates a direct=
ory
>> and returns an O_DIRECTORY fd is useful=2E
>>=20
>> This feature idea (and description) is taken from the UAPI group:
>> https://github=2Ecom/uapi-group/kernel-features?tab=3Dreadme-ov-file#ra=
ce-free-creation-and-opening-of-non-file-inodes
>>=20
>> Signed-off-by: Jori Koolstra <jkoolstra@xs4all=2Enl>
>> ---
>>   arch/x86/entry/syscalls/syscall_64=2Etbl |  1 +
>>   fs/internal=2Eh                          |  1 +
>>   fs/namei=2Ec                             | 26 +++++++++++++++++++++++=
+--
>>   include/linux/fcntl=2Eh                  |  2 ++
>>   include/linux/syscalls=2Eh               |  2 ++
>>   include/uapi/asm-generic/fcntl=2Eh       |  3 +++
>>   include/uapi/asm-generic/unistd=2Eh      |  5 ++++-
>>   scripts/syscall=2Etbl                    |  1 +
>>   8 files changed, 38 insertions(+), 3 deletions(-)
>
>> diff --git a/include/linux/fcntl=2Eh b/include/linux/fcntl=2Eh
>> index a332e79b3207=2E=2Ed2f0fdb82847 100644
>> --- a/include/linux/fcntl=2Eh
>> +++ b/include/linux/fcntl=2Eh
>> @@ -25,6 +25,8 @@
>>   #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
>>   #endif
>>   +#define VALID_MKDIRAT_FD_FLAGS	(MKDIRAT_FD_NEED_FD)
>> +
>
>I don't see support for O_CLOEXEC-ish flag, is the file descriptor in clo=
se-on-exec mode by default ? If yes, it should be mentioned=2E
>
>
>> diff --git a/include/uapi/asm-generic/fcntl=2Eh b/include/uapi/asm-gene=
ric/fcntl=2Eh
>> index 613475285643=2E=2E621458bf1fbf 100644
>> --- a/include/uapi/asm-generic/fcntl=2Eh
>> +++ b/include/uapi/asm-generic/fcntl=2Eh
>> @@ -95,6 +95,9 @@
>>   #define O_NDELAY	O_NONBLOCK
>>   #endif
>>   +/* Flags for mkdirat_fd */
>> +#define MKDIRAT_FD_NEED_FD	0x01
>> +
>
>
>Regards=2E
>
>

And even if it is, POSIX already has O_CLOFORK and we should expect that t=
hat will be needed, too=2E

