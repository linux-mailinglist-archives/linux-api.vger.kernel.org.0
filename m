Return-Path: <linux-api+bounces-2116-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802194825A
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 21:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA79281D0F
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFB216BE13;
	Mon,  5 Aug 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PxVcdz0D"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE716BE04
	for <linux-api@vger.kernel.org>; Mon,  5 Aug 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886459; cv=none; b=QFNWqLG09L7FSqQhI3jhLQIRuh6kgw22Ino5bwz+S4i7RVtH4TiSuPUW9OY95dNCcT4KmGwM9cxqSGEq7AL25oGnDIqkOrq55pJTxsQZDWNmCmkActGYDJTFTo1ol15CmVRMfuwImCrS1VMt4hM11k9bvZAQ7tn/dPZFfcLD50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886459; c=relaxed/simple;
	bh=WiV+lwMm5NzYt8US5CGvOxBobzJuEhvUWC03doxEWNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMCXQ/cpIAZY6BQWr4yleBRxm6GO5IwcJLROTCgnCa7bc4fQ8Bl+ZMAYNGDgDTKJ2H/zksgfptvXxUqdxLV7Cd2TGKX39M9hknSnlXjUjLgYJLIxYOuASICVYtbfTu0BbMbmspoPf6H7vMyPTa4OgueGWCKb2uy1J9iabkkW/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PxVcdz0D; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f1870c355cso9406891fa.1
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722886456; x=1723491256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NzT2B9YvB0hJnKZw1ow69fHG8NCpJy8+4aiEYoSj3/o=;
        b=PxVcdz0Dw4x8Ypbfnedbgb1ML7t9lLMtphGyl1MEWKf4P77bH7ZrfTQy6yEZnfdeli
         RPdvD4MPM4QDLCvJydeNjPVbrFetRDAQFGZbfuuzbW+bEGITAruZmnQfpP3vGP1UAll+
         xj7jnai5C5SVu1XgBQLwfoNIr4MhN+8FunEfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722886456; x=1723491256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzT2B9YvB0hJnKZw1ow69fHG8NCpJy8+4aiEYoSj3/o=;
        b=DsoSrEo1Vg8wheaG68u9xwuyosQt6n14JWgIkSOl1n7I0t7OWqrniijyDhC9gnvjqO
         6/Eq5cHoKJHVw4h2hbow0VF1eIIZ9NySixSkfg0MjxaoV4rjNxq0s27xse2EfWOyNqZZ
         XxN6xYv87Uxcnqpp3aV0MCAN7rPhNRh2E36XXQjV+WvmMOTPRplJzLl2ctmfnFo7xASu
         566Ou00YOuMk/1FmLwRbnboGpIeNHoAxPum0cC6wE8W/fhyIFTwfP9nYLxNbw6yARjYS
         ByeQZAsz6+mved+5h7qtZVqrljmRAxZvOk2719LfnBFfhMCraz+Ca+okZ7e23CNI/YEH
         LyYg==
X-Forwarded-Encrypted: i=1; AJvYcCXg8OZ0lD3Q649PPNqZyxe1XhRhunOu7HBPFy2xKSDt3swgT7fSpr0peAa/uylBpVg0V3/OKHSMpO+u5W70WUH+SeXAT7p5PuDu
X-Gm-Message-State: AOJu0YwlxlYYXpaXw73YuVys9ymXHsJgkVOkBPFW5KH98VQZG1RvnOWk
	EPU2BzDAJAxVpCtRm9BuzsHIZmGmfQRe1iALBHN7nx102pCP+UKEckKsbyq7SAzuhF3PalJ8sFE
	SGp7hhg==
X-Google-Smtp-Source: AGHT+IGUvjjyaa/Y1y5o4CczqhajO+v9rX9kWVi/dwHu/S8U/UmB0Mkcs44o1/qOQhUHD9itWfvznQ==
X-Received: by 2002:a2e:2c11:0:b0:2ef:243b:6dce with SMTP id 38308e7fff4ca-2f15aa84ec7mr76738711fa.10.1722886455502;
        Mon, 05 Aug 2024 12:34:15 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb977d661esm250373a12.28.2024.08.05.12.34.15
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:34:15 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7de4364ca8so262137266b.2
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 12:34:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6NP+mgzGRUndGYkeU4Q6q2TGr2nbgGEEdDDn27uN2bEI6l5sV+p8F1lHJl/sd0K+Iej6NSQ+qBMHnnSd2LIkR1Qr9ThH+7Gbg
X-Received: by 2002:a17:906:f5a6:b0:a77:b726:4fc with SMTP id
 a640c23a62f3a-a7dc4dc193fmr950383566b.1.1722886454780; Mon, 05 Aug 2024
 12:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com> <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
In-Reply-To: <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 12:33:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
Message-ID: <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Jeff Xu <jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, kernel test robot <oliver.sang@intel.com>, 
	Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Guenter Roeck <groeck@chromium.org>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="000000000000205ca7061ef4c39c"

--000000000000205ca7061ef4c39c
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 11:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So please consider this a "maybe something like this" patch, but that
> 'arch_unmap()' really is pretty nasty

Actually, the whole powerpc vdso code confused me. It's not the vvar
thing that wants this close thing, it's the other ones that have the
remap thing.

.. and there were two of those error cases that needed to reset the
vdso pointer.

That all shows just how carefully I was reading this code.

New version - still untested, but now I've read through it one more
time - attached.

                Linus

--000000000000205ca7061ef4c39c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lzhe3lwz0>
X-Attachment-Id: f_lzhe3lwz0

IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oIHwgIDkgLS0tLS0tLS0tCiBh
cmNoL3Bvd2VycGMva2VybmVsL3Zkc28uYyAgICAgICAgICAgICB8IDE3ICsrKysrKysrKysrKysr
Ky0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oICAgICB8ICA1IC0tLS0tCiBp
bmNsdWRlL2FzbS1nZW5lcmljL21tX2hvb2tzLmggICAgICAgICB8IDExICsrKy0tLS0tLS0tCiBp
bmNsdWRlL2xpbnV4L21tX3R5cGVzLmggICAgICAgICAgICAgICB8ICAyICsrCiBtbS9tbWFwLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKysrKy0tLS0tLS0tLQogNiBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaCBiL2FyY2gvcG93ZXJwYy9p
bmNsdWRlL2FzbS9tbXVfY29udGV4dC5oCmluZGV4IDM3YmZmYTBmNzkxOC4uYTMzNGExMzY4ODQ4
IDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaAorKysg
Yi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaApAQCAtMjYwLDE1ICsyNjAs
NiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZW50ZXJfbGF6eV90bGIoc3RydWN0IG1tX3N0cnVjdCAq
bW0sCiAKIGV4dGVybiB2b2lkIGFyY2hfZXhpdF9tbWFwKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsK
IAotc3RhdGljIGlubGluZSB2b2lkIGFyY2hfdW5tYXAoc3RydWN0IG1tX3N0cnVjdCAqbW0sCi0J
CQkgICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCkKLXsKLQl1bnNp
Z25lZCBsb25nIHZkc29fYmFzZSA9ICh1bnNpZ25lZCBsb25nKW1tLT5jb250ZXh0LnZkc287Ci0K
LQlpZiAoc3RhcnQgPD0gdmRzb19iYXNlICYmIHZkc29fYmFzZSA8IGVuZCkKLQkJbW0tPmNvbnRl
eHQudmRzbyA9IE5VTEw7Ci19Ci0KICNpZmRlZiBDT05GSUdfUFBDX01FTV9LRVlTCiBib29sIGFy
Y2hfdm1hX2FjY2Vzc19wZXJtaXR0ZWQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIGJvb2wg
d3JpdGUsCiAJCQkgICAgICAgYm9vbCBleGVjdXRlLCBib29sIGZvcmVpZ24pOwpkaWZmIC0tZ2l0
IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC92ZHNvLmMgYi9hcmNoL3Bvd2VycGMva2VybmVsL3Zkc28u
YwppbmRleCA3YTJmZjkwMTBmMTcuLjZmYTA0MWE2NjkwYSAxMDA2NDQKLS0tIGEvYXJjaC9wb3dl
cnBjL2tlcm5lbC92ZHNvLmMKKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC92ZHNvLmMKQEAgLTgx
LDYgKzgxLDEzIEBAIHN0YXRpYyBpbnQgdmRzbzY0X21yZW1hcChjb25zdCBzdHJ1Y3Qgdm1fc3Bl
Y2lhbF9tYXBwaW5nICpzbSwgc3RydWN0IHZtX2FyZWFfc3RyCiAJcmV0dXJuIHZkc29fbXJlbWFw
KHNtLCBuZXdfdm1hLCAmdmRzbzY0X2VuZCAtICZ2ZHNvNjRfc3RhcnQpOwogfQogCitzdGF0aWMg
aW50IHZ2YXJfY2xvc2UoY29uc3Qgc3RydWN0IHZtX3NwZWNpYWxfbWFwcGluZyAqc20sCisJCSAg
ICAgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQoreworCXN0cnVjdCBtbV9zdHJ1Y3QgKm1t
ID0gdm1hLT52bV9tbTsKKwltbS0+Y29udGV4dC52ZHNvID0gTlVMTDsKK30KKwogc3RhdGljIHZt
X2ZhdWx0X3QgdnZhcl9mYXVsdChjb25zdCBzdHJ1Y3Qgdm1fc3BlY2lhbF9tYXBwaW5nICpzbSwK
IAkJCSAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHN0cnVjdCB2bV9mYXVsdCAqdm1m
KTsKIApAQCAtOTIsMTEgKzk5LDEzIEBAIHN0YXRpYyBzdHJ1Y3Qgdm1fc3BlY2lhbF9tYXBwaW5n
IHZ2YXJfc3BlYyBfX3JvX2FmdGVyX2luaXQgPSB7CiBzdGF0aWMgc3RydWN0IHZtX3NwZWNpYWxf
bWFwcGluZyB2ZHNvMzJfc3BlYyBfX3JvX2FmdGVyX2luaXQgPSB7CiAJLm5hbWUgPSAiW3Zkc29d
IiwKIAkubXJlbWFwID0gdmRzbzMyX21yZW1hcCwKKwkuY2xvc2UgPSB2dmFyX2Nsb3NlLAogfTsK
IAogc3RhdGljIHN0cnVjdCB2bV9zcGVjaWFsX21hcHBpbmcgdmRzbzY0X3NwZWMgX19yb19hZnRl
cl9pbml0ID0gewogCS5uYW1lID0gIlt2ZHNvXSIsCiAJLm1yZW1hcCA9IHZkc282NF9tcmVtYXAs
CisJLmNsb3NlID0gdnZhcl9jbG9zZSwKIH07CiAKICNpZmRlZiBDT05GSUdfVElNRV9OUwpAQCAt
MjA3LDggKzIxNiwxMCBAQCBzdGF0aWMgaW50IF9fYXJjaF9zZXR1cF9hZGRpdGlvbmFsX3BhZ2Vz
KHN0cnVjdCBsaW51eF9iaW5wcm0gKmJwcm0sIGludCB1c2VzX2ludAogCXZtYSA9IF9pbnN0YWxs
X3NwZWNpYWxfbWFwcGluZyhtbSwgdmRzb19iYXNlLCB2dmFyX3NpemUsCiAJCQkJICAgICAgIFZN
X1JFQUQgfCBWTV9NQVlSRUFEIHwgVk1fSU8gfAogCQkJCSAgICAgICBWTV9ET05URFVNUCB8IFZN
X1BGTk1BUCwgJnZ2YXJfc3BlYyk7Ci0JaWYgKElTX0VSUih2bWEpKQorCWlmIChJU19FUlIodm1h
KSkgeworCQltbS0+Y29udGV4dC52ZHNvID0gTlVMTDsKIAkJcmV0dXJuIFBUUl9FUlIodm1hKTsK
Kwl9CiAKIAkvKgogCSAqIG91ciB2bWEgZmxhZ3MgZG9uJ3QgaGF2ZSBWTV9XUklURSBzbyBieSBk
ZWZhdWx0LCB0aGUgcHJvY2VzcyBpc24ndApAQCAtMjIzLDggKzIzNCwxMCBAQCBzdGF0aWMgaW50
IF9fYXJjaF9zZXR1cF9hZGRpdGlvbmFsX3BhZ2VzKHN0cnVjdCBsaW51eF9iaW5wcm0gKmJwcm0s
IGludCB1c2VzX2ludAogCXZtYSA9IF9pbnN0YWxsX3NwZWNpYWxfbWFwcGluZyhtbSwgdmRzb19i
YXNlICsgdnZhcl9zaXplLCB2ZHNvX3NpemUsCiAJCQkJICAgICAgIFZNX1JFQUQgfCBWTV9FWEVD
IHwgVk1fTUFZUkVBRCB8CiAJCQkJICAgICAgIFZNX01BWVdSSVRFIHwgVk1fTUFZRVhFQywgdmRz
b19zcGVjKTsKLQlpZiAoSVNfRVJSKHZtYSkpCisJaWYgKElTX0VSUih2bWEpKSB7CisJCW1tLT5j
b250ZXh0LnZkc28gPSBOVUxMOwogCQlkb19tdW5tYXAobW0sIHZkc29fYmFzZSwgdnZhcl9zaXpl
LCBOVUxMKTsKKwl9CiAKIAlyZXR1cm4gUFRSX0VSUl9PUl9aRVJPKHZtYSk7CiB9CmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbW11X2NvbnRleHQuaAppbmRleCA4ZGFjNDVhMmM3ZmMuLjgwZjJhMzE4N2FhNiAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaAorKysgYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oCkBAIC0yMzIsMTEgKzIzMiw2IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCBpc182NGJpdF9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIH0KICNlbmRpZgog
Ci1zdGF0aWMgaW5saW5lIHZvaWQgYXJjaF91bm1hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5z
aWduZWQgbG9uZyBzdGFydCwKLQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgZW5kKQotewotfQotCiAv
KgogICogV2Ugb25seSB3YW50IHRvIGVuZm9yY2UgcHJvdGVjdGlvbiBrZXlzIG9uIHRoZSBjdXJy
ZW50IHByb2Nlc3MKICAqIGJlY2F1c2Ugd2UgZWZmZWN0aXZlbHkgaGF2ZSBubyBhY2Nlc3MgdG8g
UEtSVSBmb3Igb3RoZXIKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvbW1faG9va3Mu
aCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvbW1faG9va3MuaAppbmRleCA0ZGJiMTc3ZDExNTAuLjZl
ZWEzYjNjMWU2NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9tbV9ob29rcy5oCisr
KyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvbW1faG9va3MuaApAQCAtMSw4ICsxLDggQEAKIC8qIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovCiAvKgotICogRGVmaW5lIGdlbmVyaWMg
bm8tb3AgaG9va3MgZm9yIGFyY2hfZHVwX21tYXAsIGFyY2hfZXhpdF9tbWFwCi0gKiBhbmQgYXJj
aF91bm1hcCB0byBiZSBpbmNsdWRlZCBpbiBhc20tRk9PL21tdV9jb250ZXh0LmggZm9yIGFueQot
ICogYXJjaCBGT08gd2hpY2ggZG9lc24ndCBuZWVkIHRvIGhvb2sgdGhlc2UuCisgKiBEZWZpbmUg
Z2VuZXJpYyBuby1vcCBob29rcyBmb3IgYXJjaF9kdXBfbW1hcCBhbmQgYXJjaF9leGl0X21tYXAK
KyAqIHRvIGJlIGluY2x1ZGVkIGluIGFzbS1GT08vbW11X2NvbnRleHQuaCBmb3IgYW55IGFyY2gg
Rk9PIHdoaWNoCisgKiBkb2Vzbid0IG5lZWQgdG8gaG9vayB0aGVzZS4KICAqLwogI2lmbmRlZiBf
QVNNX0dFTkVSSUNfTU1fSE9PS1NfSAogI2RlZmluZSBfQVNNX0dFTkVSSUNfTU1fSE9PS1NfSApA
QCAtMTcsMTEgKzE3LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGFyY2hfZXhpdF9tbWFwKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tKQogewogfQogCi1zdGF0aWMgaW5saW5lIHZvaWQgYXJjaF91bm1hcChz
dHJ1Y3QgbW1fc3RydWN0ICptbSwKLQkJCXVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxv
bmcgZW5kKQotewotfQotCiBzdGF0aWMgaW5saW5lIGJvb2wgYXJjaF92bWFfYWNjZXNzX3Blcm1p
dHRlZChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKIAkJYm9vbCB3cml0ZSwgYm9vbCBleGVj
dXRlLCBib29sIGZvcmVpZ24pCiB7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tX3R5cGVz
LmggYi9pbmNsdWRlL2xpbnV4L21tX3R5cGVzLmgKaW5kZXggNDg1NDI0OTc5MjU0Li5lZjMyZDg3
YTNhZGMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW1fdHlwZXMuaAorKysgYi9pbmNsdWRl
L2xpbnV4L21tX3R5cGVzLmgKQEAgLTEzMTMsNiArMTMxMyw4IEBAIHN0cnVjdCB2bV9zcGVjaWFs
X21hcHBpbmcgewogCiAJaW50ICgqbXJlbWFwKShjb25zdCBzdHJ1Y3Qgdm1fc3BlY2lhbF9tYXBw
aW5nICpzbSwKIAkJICAgICBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKm5ld192bWEpOworCXZvaWQg
KCpjbG9zZSkoY29uc3Qgc3RydWN0IHZtX3NwZWNpYWxfbWFwcGluZyAqc20sCisJCSAgICAgIHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKTsKIH07CiAKIGVudW0gdGxiX2ZsdXNoX3JlYXNvbiB7
CmRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9tbS9tbWFwLmMKaW5kZXggZDBkZmM4NWIyMDliLi5h
ZGFhZjFlZjE5N2EgMTAwNjQ0Ci0tLSBhL21tL21tYXAuYworKysgYi9tbS9tbWFwLmMKQEAgLTI3
ODksNyArMjc4OSw3IEBAIGRvX3ZtaV9hbGlnbl9tdW5tYXAoc3RydWN0IHZtYV9pdGVyYXRvciAq
dm1pLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKICAqCiAgKiBUaGlzIGZ1bmN0aW9uIHRh
a2VzIGEgQG1hcyB0aGF0IGlzIGVpdGhlciBwb2ludGluZyB0byB0aGUgcHJldmlvdXMgVk1BIG9y
IHNldAogICogdG8gTUFfU1RBUlQgYW5kIHNldHMgaXQgdXAgdG8gcmVtb3ZlIHRoZSBtYXBwaW5n
KHMpLiAgVGhlIEBsZW4gd2lsbCBiZQotICogYWxpZ25lZCBhbmQgYW55IGFyY2hfdW5tYXAgd29y
ayB3aWxsIGJlIHByZWZvcm1lZC4KKyAqIGFsaWduZWQuCiAgKgogICogUmV0dXJuOiAwIG9uIHN1
Y2Nlc3MgYW5kIGRyb3BzIHRoZSBsb2NrIGlmIHNvIGRpcmVjdGVkLCBlcnJvciBhbmQgbGVhdmVz
IHRoZQogICogbG9jayBoZWxkIG90aGVyd2lzZS4KQEAgLTI4MDksMTYgKzI4MDksMTIgQEAgaW50
IGRvX3ZtaV9tdW5tYXAoc3RydWN0IHZtYV9pdGVyYXRvciAqdm1pLCBzdHJ1Y3QgbW1fc3RydWN0
ICptbSwKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAkvKgotCSAqIENoZWNrIGlmIG1lbW9yeSBpcyBz
ZWFsZWQgYmVmb3JlIGFyY2hfdW5tYXAuCi0JICogUHJldmVudCB1bm1hcHBpbmcgYSBzZWFsZWQg
Vk1BLgorCSAqIENoZWNrIGlmIG1lbW9yeSBpcyBzZWFsZWQsIHByZXZlbnQgdW5tYXBwaW5nIGEg
c2VhbGVkIFZNQS4KIAkgKiBjYW5fbW9kaWZ5X21tIGFzc3VtZXMgd2UgaGF2ZSBhY3F1aXJlZCB0
aGUgbG9jayBvbiBNTS4KIAkgKi8KIAlpZiAodW5saWtlbHkoIWNhbl9tb2RpZnlfbW0obW0sIHN0
YXJ0LCBlbmQpKSkKIAkJcmV0dXJuIC1FUEVSTTsKIAotCSAvKiBhcmNoX3VubWFwKCkgbWlnaHQg
ZG8gdW5tYXBzIGl0c2VsZi4gICovCi0JYXJjaF91bm1hcChtbSwgc3RhcnQsIGVuZCk7Ci0KIAkv
KiBGaW5kIHRoZSBmaXJzdCBvdmVybGFwcGluZyBWTUEgKi8KIAl2bWEgPSB2bWFfZmluZCh2bWks
IGVuZCk7CiAJaWYgKCF2bWEpIHsKQEAgLTMyMzIsMTQgKzMyMjgsMTIgQEAgaW50IGRvX3ZtYV9t
dW5tYXAoc3RydWN0IHZtYV9pdGVyYXRvciAqdm1pLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSwKIAlzdHJ1Y3QgbW1fc3RydWN0ICptbSA9IHZtYS0+dm1fbW07CiAKIAkvKgotCSAqIENoZWNr
IGlmIG1lbW9yeSBpcyBzZWFsZWQgYmVmb3JlIGFyY2hfdW5tYXAuCi0JICogUHJldmVudCB1bm1h
cHBpbmcgYSBzZWFsZWQgVk1BLgorCSAqIENoZWNrIGlmIG1lbW9yeSBpcyBzZWFsZWQsIHByZXZl
bnQgdW5tYXBwaW5nIGEgc2VhbGVkIFZNQS4KIAkgKiBjYW5fbW9kaWZ5X21tIGFzc3VtZXMgd2Ug
aGF2ZSBhY3F1aXJlZCB0aGUgbG9jayBvbiBNTS4KIAkgKi8KIAlpZiAodW5saWtlbHkoIWNhbl9t
b2RpZnlfbW0obW0sIHN0YXJ0LCBlbmQpKSkKIAkJcmV0dXJuIC1FUEVSTTsKIAotCWFyY2hfdW5t
YXAobW0sIHN0YXJ0LCBlbmQpOwogCXJldHVybiBkb192bWlfYWxpZ25fbXVubWFwKHZtaSwgdm1h
LCBtbSwgc3RhcnQsIGVuZCwgdWYsIHVubG9jayk7CiB9CiAKQEAgLTM2MjQsNiArMzYxOCw5IEBA
IHN0YXRpYyB2bV9mYXVsdF90IHNwZWNpYWxfbWFwcGluZ19mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQg
KnZtZik7CiAgKi8KIHN0YXRpYyB2b2lkIHNwZWNpYWxfbWFwcGluZ19jbG9zZShzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSkKIHsKKwljb25zdCBzdHJ1Y3Qgdm1fc3BlY2lhbF9tYXBwaW5nICpz
bSA9IHZtYS0+dm1fcHJpdmF0ZV9kYXRhOworCWlmIChzbS0+Y2xvc2UpCisJCXNtLT5jbG9zZShz
bSwgdm1hKTsKIH0KIAogc3RhdGljIGNvbnN0IGNoYXIgKnNwZWNpYWxfbWFwcGluZ19uYW1lKHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQo=
--000000000000205ca7061ef4c39c--

