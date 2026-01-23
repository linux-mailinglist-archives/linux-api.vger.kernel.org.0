Return-Path: <linux-api+bounces-5745-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Iq+MQLEc2kCygAAu9opvQ
	(envelope-from <linux-api+bounces-5745-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 19:54:58 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D24C79DB9
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 19:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C35F630055B1
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154CE239E9A;
	Fri, 23 Jan 2026 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azPsTssj"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D318218AAD
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194494; cv=pass; b=Vu0yUShG+UXhVykc37eREu5OVtSMsFpNbl4uR45NBu3zA8cpOiYpniQDywXXwbiv3d6ll2O/YUanV0YdsC4MylvKeiGUmSlfA4IjSFZKX9pKwUTN5L1x7tjX5MSx1nGDcB6y6LG5oGl0BIBpzAbHuhMd7i6uEQteFhJ3wQ0D9h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194494; c=relaxed/simple;
	bh=mogKnU+/3Gpm3+TCKIivbq94eYQH9qfmDATkiFrBSF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qv+zCHGp7dZzrQYFkL+1XkFup/FgxdEaZ60Jr12Nus9BaxkPU1m+kEEXtphL08Pro/MdKxxbdUP1Y3Zbs9w7NKz440b6y/CXb/2t54c+bA1q2t4kdDBQWbdW7ZCG+Hon84/ExWX6jvhzsn8SnYOGYxaPyE8rdX0cByNnRz+MHho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azPsTssj; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso1657037a12.1
        for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 10:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194492; cv=none;
        d=google.com; s=arc-20240605;
        b=DJTz/+MoKFx2sJ5tSMcRm5TVyCBthGOlBKzt8ByDlpGxDYKxN420DgupWDbdNbCrhq
         42/SgTJzZuvVrxn292hPlHPhoRnDAvcVwD+WNn7ciTg33NqzpCpt3aF2z/7HxgnSwXMT
         hVUPY3Tlmr0B1MZ+416QS34/asn5Wmso67pVi87df+sBB9eFVuYNPyv1njGQWTQcIjz5
         364j5QKBRwXP7/fpNMIfdoiQ29CHAM5yVQKj16XXISkqZ3mAtvwKcZyFL3IoJSbufilb
         g6wMjUGoJYt+TnIrTfU1c+97A1x10b2FRl1VQ7D75zQue17TUVo+W2r192aDrGJ34r30
         AUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYmPiHRJ1VjBncSc3bQynnNatD06b0uPrSBt7EelaoA=;
        fh=WjQyGPY9/F7QU76BJsTr/TsMUVLh7LpdA0j8a3MYxVg=;
        b=DEWD2dyoW1DcnvbMUn2XogEL4LbnvyH/PjqUqzPMVf3QlLR3NU9jNkLnOET9PTHLyL
         RGKuiUbZeEN6JYDlEstdXRQ01G6nuRStpyNXJOhDTMxfsXAENxovPE/1qyqUJ4ykwvJm
         m0eqKkz93oOgPVGs9404MWhjW8e729AaIYNdFuRvTchFhkTPa+IEsYcfjR7HfMhozsTJ
         rs96MxQ9EvKjrtJYlF+s0IG6Qlfk3i1U2xCxOFoZFeyijd63Q9lMEJJdfo88FHEd9HYK
         5Dx6oUkkShqIhA3fhPH56NqlgqbvaxoRW9HN2mL6bxlqz3S80iUxRaexA+PXehcQeqJ7
         gRbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194492; x=1769799292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYmPiHRJ1VjBncSc3bQynnNatD06b0uPrSBt7EelaoA=;
        b=azPsTssjg29Vs4wLIzjZFP/Nk7GTIgAVC6iGTmAsj/Hdad1VkjZOiD40/raEvsR7EQ
         m1C7G0U/VR6gnEK/XAVgODZv5CtipRqMWBH/w8zyhzclos3II7dZcU9Puf1q1bp4My5e
         My8iN39aZW4dAKY2ZsGrpdZX2Ggana5AXE5ZVrMo+nsoAu4sXr+TSG0egBc75vzUc4Wb
         /H3VHK2+pqTWROAiKWmxAXRQr4q4PbpyTZg/XN0olDw6myZhQ3+7tp0mFdGYOBDpeSL/
         9EtbtSPoxvC62QfRyNwm6RT1b+7gk/k/IMNM7f0c+cFrVX5GJVVmHikkGT4db04ufPnJ
         iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194492; x=1769799292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYmPiHRJ1VjBncSc3bQynnNatD06b0uPrSBt7EelaoA=;
        b=kdCXFMuHn0mGgO0GveneouUgEu+F/KmE2OT2pobqyHowdks9OxoMk7B4wb3SERkMCn
         WpWxf7MBPNHXSRiybp/qWkuBMcnGEXObbgvzCdpWVcZiC/EGCqpxJtQKqOIDLZsabsEQ
         cNeMrjWt9S8s1WVHDiU5lkZeejOifbok5ktbCpSdwMocBCFpAi3zTykOyaGcf7K0OmeD
         E3CTrCD/LRCLaMkbg3noW4962KxweagNPrTHZFtRPSYN+DL8V2VkqVstpLHdQp+JWS/s
         54xTyhzYhDa5oJGM3ZNzNsAIFN/ZudCgIomsG1u3VOimBai6Q6fnqdJr23UJfAb/MeK1
         h32w==
X-Forwarded-Encrypted: i=1; AJvYcCUerlmumlWnqUSJDq2tccmnl/nVb6lq+UZIypOD5mdiXQ4qY+173a0cxdB8WGgqP7yMgVN74MAhso4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+iDTzXTi9yDRc1TE2x/rsZ+q27R2diuwsSu3DVJTJxCT3UxE
	34v1zMg4DDXDssNaXG8RV5yhYQNOeyYaWuzU5FpTryB+9oCT70nKD/Q/9X0kI6qQA/vdRZZ+57e
	itvAKjI/mIDW2caAb4UaBEiW5TqL9fmY=
X-Gm-Gg: AZuq6aLTWf4+Q5uVYQ5ZRs1sVYZyS4gUS88yohGnMph7BIiKLfQ8kYXgRzfxKeiHt13
	PVYVofbkJlmejm8RmX6WbvMBRtU1UBNd2+xDChy+Uo4RtY/+tvtiY/37k76kWVTw+u+78oDBEhI
	MsPJe/U1+OrsJ+lpLRA6/7BKTqqG75DDS7twrritx4vfXPgOjLTl1MTqSD8HtxkIrzcmZJxCi34
	47jcm7vkfbwnN+hdGX/pzy06LsTPYjo7A3pwqMmHZZ34l+oiSc7QKvdCNr81IvC9Q6Y6heV+gVL
	YzCLQZcZHQg=
X-Received: by 2002:a17:90a:e185:b0:349:5b1b:78be with SMTP id
 98e67ed59e1d1-353688574b1mr3895164a91.17.1769194491806; Fri, 23 Jan 2026
 10:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152424.40766-1-leon.hwang@linux.dev> <20260120152424.40766-3-leon.hwang@linux.dev>
 <CAEf4BzYuZsFC-DPhhzLcyFTahucHP59+6kAc0sooY2g+SqgrEA@mail.gmail.com> <d8f37588-2b7d-447a-ae4f-dc81e1b573c5@linux.dev>
In-Reply-To: <d8f37588-2b7d-447a-ae4f-dc81e1b573c5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 10:54:37 -0800
X-Gm-Features: AZwV_Qi3JozEFDMkX_Qj_HRM7VamKhm_b4P9yeRYSoUDV7xr3lmnoWFfgWxKG6U
Message-ID: <CAEf4Bzb_V4p7XvE6e2CUfbKhfjh96i-_mCYa-osWiSGwWObmrQ@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v6 2/9] libbpf: Add support for extended
 bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5745-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 5D24C79DB9
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 5:41=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 23/1/26 08:53, Andrii Nakryiko wrote:
> > On Tue, Jan 20, 2026 at 7:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> To support the extended BPF syscall introduced in the previous commit,
> >> introduce the following internal APIs:
> >>
> >> * 'sys_bpf_ext()'
> >> * 'sys_bpf_ext_fd()'
> >>   They wrap the raw 'syscall()' interface to support passing extended
> >>   attributes.
> >> * 'probe_sys_bpf_ext()'
> >>   Check whether current kernel supports the BPF syscall common attribu=
tes.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c             | 32 ++++++++++++++++++++++++++++++++
> >>  tools/lib/bpf/features.c        |  8 ++++++++
> >>  tools/lib/bpf/libbpf_internal.h |  3 +++
> >>  3 files changed, 43 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index 21b57a629916..ed9c6eaeb656 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -69,6 +69,38 @@ static inline __u64 ptr_to_u64(const void *ptr)
> >>         return (__u64) (unsigned long) ptr;
> >>  }
> >>
> >> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> >> +                             unsigned int size,
> >> +                             struct bpf_common_attr *attr_common,
> >> +                             unsigned int size_common)
> >> +{
> >> +       cmd =3D attr_common ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_C=
OMMON_ATTRS);
> >> +       return syscall(__NR_bpf, cmd, attr, size, attr_common, size_co=
mmon);
> >> +}
> >> +
> >> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *at=
tr,
> >> +                                unsigned int size,
> >> +                                struct bpf_common_attr *attr_common,
> >> +                                unsigned int size_common)
> >> +{
> >> +       int fd;
> >> +
> >> +       fd =3D sys_bpf_ext(cmd, attr, size, attr_common, size_common);
> >> +       return ensure_good_fd(fd);
> >> +}
> >> +
> >> +int probe_sys_bpf_ext(void)
> >> +{
> >> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_toke=
n_fd);
> >> +       union bpf_attr attr;
> >> +
> >> +       memset(&attr, 0, attr_sz);
> >> +       /* This syscall() will return error always. */
> >
> > I'll cite myself from the last review:
> >
> >> But fd should really not be >=3D 0, and if it is -- it's some problem,
> >> so I'd return an error in that case to keep us aware, which is why I'm
> >> saying I'd just return inside if (fd >=3D 0) { }
> >
> > I didn't say let's just ignore syscall return with (void) cast and
> > happily check errno no matter what, did I? Drop the comment, and
> > handle fd >=3D 0 case explicitly, please.
> >
>
> My mistake =E2=80=94 sorry for the misunderstanding.
>
> You=E2=80=99re right; the return value should not be ignored. In the next
> revision, I=E2=80=99ll handle the fd >=3D 0 case explicitly and drop the =
comment.
> The logic will be updated along the lines of:
>
> fd =3D syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS,
>              &attr, attr_sz, NULL, sizeof(struct bpf_common_attr));
> if (fd >=3D 0) {
>         close(fd);
>         return 0;
> }
> return errno =3D=3D EFAULT;
>

well no, it should be

fd =3D syscall(...);
if (fd >=3D 0) {
    close(fd);
    return -EINVAL;
}

return errno =3D=3D EFAULT ? 1 : 0;

> Thanks,
> Leon
>
>

