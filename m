Return-Path: <linux-api+bounces-489-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1482B5BA
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 21:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AF02869D3
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A356B62;
	Thu, 11 Jan 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QBLhwdLL"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6E56779
	for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e55c885d7so25967945e9.0
        for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705004067; x=1705608867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MyTiefZUsYAN2QjaStpgms/QKgfX1VBSwRtQTNj32xo=;
        b=QBLhwdLLsFp2CThRaiCUkkxTMIj5eyyOA1inQ33gthsF+lIJkBJOqjj9MSTyz3iTEi
         KdveziwMyPcjwe93xrfyD7eE18a0etCPXoc8Y0ups7SIJuq0BFLzZ01037llQDPqCK1G
         /pBeCn40eRG6Iu1L7MuFR1q4sVcGtVqrKTuTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004067; x=1705608867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyTiefZUsYAN2QjaStpgms/QKgfX1VBSwRtQTNj32xo=;
        b=Ih+A6v9jNAXnxGzy0cb6p7JnO1Kxyl9WhW9HUqIofVzdKa6YJ4XNBVYCQcllH7+hUp
         PGUdCLW6+QdYTAnvdQ/xb7zvpvasdoU7GpUFD7TrjPdZFYWnXxnnPx+u2F/tbKyzS5G4
         zT5ROCWElzegsJvt+wqG4GWos3WIbfQ9xp974di/DcGrYPwPRJI2OhbdrHkb6xaGuUY4
         VeEB6TEMJ5cXJ6gabTogPBOBFZSxv6EfaeIiVMInDLmEB8bqLNRGkXAViEvMLkphpZ2u
         B8kTf8X5oZVdpok4OUeAIV55YjmY919ZvBo9ehns+KCBdERgtRDwwEQo428MFZry7Uf0
         V06Q==
X-Gm-Message-State: AOJu0YwOYZvy9ZOf1AwNpQLQsLI/tZ93u2qr3R3g8CX9IP7wXwZdD7jE
	RT1TMXGkL+TnEdlN3dW+cWpryKyxKJvMPonTSbrNqEeVHSGnJ8RN
X-Google-Smtp-Source: AGHT+IHad6IfOHbUG8Oxpi+aV0tn1SK9p+/p5Q75evmvb9JyCM2SLyov00EBJ7/CVH8rYGuwG35tHg==
X-Received: by 2002:a7b:c851:0:b0:40e:4d64:1fff with SMTP id c17-20020a7bc851000000b0040e4d641fffmr193486wml.139.1705004067633;
        Thu, 11 Jan 2024 12:14:27 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b00a2c4c23cd12sm941554ejb.217.2024.01.11.12.14.25
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 12:14:25 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e63bc90f2so1171915e9.2
        for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 12:14:25 -0800 (PST)
X-Received: by 2002:a7b:c4cb:0:b0:40d:87b7:24c7 with SMTP id
 g11-20020a7bc4cb000000b0040d87b724c7mr206716wmk.125.1705004065149; Thu, 11
 Jan 2024 12:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net> <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
 <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net>
In-Reply-To: <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 12:14:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
Message-ID: <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary="000000000000a535af060eb13163"

--000000000000a535af060eb13163
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 10:57, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Any variance of put_user() with &buf[ctr] or buf + ctr fails
> if ctr is a variable and permitted to be != 0.

Crazy. But the 64-bit put_user() is a bit special and tends to require
more registers (the 64-bit value is passed in two registers), so that
probably then results in the ICE.

Side note: looking at the SH version of __put_user_u64(), I think it's
buggy and is missing the exception handler for the second 32-bit move.
I dunno, I don't read sh asm, but it looks suspicious.

> The following works. Would this be acceptable ?

It might be very easy to trigger this once again if somebody goes "that's silly"

That said, I also absolutely detest the "error handling" in that
function. It's horrible.

Noticing the user access error in the middle is just sad, and if that
was just handled better and at least the range was checked first, the
overflow error couldn't happen and checking for it is thus pointless.

And looking at it all, it really looks like the whole interface is
broken. The "bufsize" argument isn't the size of the buffer at all.
It's the number of entries.

Extra confusingly, in the *other* system call, bufsize is in fact the
size of the buffer.

And the 'ctr' overflow checking is doubly garbage, because the only
reason *that* can happen is that we didn't check the incoming
arguments properly.

Same goes for the whole array_index_nospec() - it's pointless, because
the user controls what that code checks against anyway, so there's no
point to trying to manage some range checking.

The only range checking there that matters would be the one that
put_user() has to do against the address space size, but that's done
by put_user().

End result: that thing needs a rewrite.

The SH put_user64() needs to be looked at too, but in the meantime,
maybe something like this fixes the problems with listmount?

NOTE! ENTIRELY untested, but that naming and lack of argument sanity
checking really is horrendous. We should have caught this earlier.

                   Linus

--000000000000a535af060eb13163
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lr9ndngy0>
X-Attachment-Id: f_lr9ndngy0

IGZzL25hbWVzcGFjZS5jIHwgMzEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2ZzL25hbWVzcGFjZS5jIGIvZnMvbmFtZXNwYWNlLmMKaW5kZXggZWYxZmQ2ODI5ODE0Li5k
Zjc0ZjQ3Njk3MzMgMTAwNjQ0Ci0tLSBhL2ZzL25hbWVzcGFjZS5jCisrKyBiL2ZzL25hbWVzcGFj
ZS5jCkBAIC01MDQzLDEyICs1MDQzLDE3IEBAIHN0YXRpYyBzdHJ1Y3QgbW91bnQgKmxpc3RtbnRf
bmV4dChzdHJ1Y3QgbW91bnQgKmN1cnIpCiB9CiAKIHN0YXRpYyBzc2l6ZV90IGRvX2xpc3Rtb3Vu
dChzdHJ1Y3QgbW91bnQgKmZpcnN0LCBzdHJ1Y3QgcGF0aCAqb3JpZywgdTY0IG1udF9pZCwKLQkJ
CSAgICB1NjQgX191c2VyICpidWYsIHNpemVfdCBidWZzaXplLAorCQkJICAgIHU2NCBfX3VzZXIg
KmJ1Ziwgc2l6ZV90IG5lbnRyaWVzLAogCQkJICAgIGNvbnN0IHN0cnVjdCBwYXRoICpyb290KQog
ewogCXN0cnVjdCBtb3VudCAqcjsKLQlzc2l6ZV90IGN0cjsKLQlpbnQgZXJyOworCWNvbnN0IHNp
emVfdCBtYXhlbnRyaWVzID0gKHNpemVfdCktMSA+PiAzOworCXNzaXplX3QgcmV0OworCisJaWYg
KHVubGlrZWx5KG5lbnRyaWVzID4gbWF4ZW50cmllcykpCisJCXJldHVybiAtRUZBVUxUOworCWlm
ICghYWNjZXNzX29rKGJ1ZiwgbmVudHJpZXMgKiBzaXplb2YoKmJ1ZikpKQorCQlyZXR1cm4gLUVG
QVVMVDsKIAogCS8qCiAJICogRG9uJ3QgdHJpZ2dlciBhdWRpdCBkZW5pYWxzLiBXZSBqdXN0IHdh
bnQgdG8gZGV0ZXJtaW5lIHdoYXQKQEAgLTUwNTgsMjYgKzUwNjMsMjQgQEAgc3RhdGljIHNzaXpl
X3QgZG9fbGlzdG1vdW50KHN0cnVjdCBtb3VudCAqZmlyc3QsIHN0cnVjdCBwYXRoICpvcmlnLCB1
NjQgbW50X2lkLAogCSAgICAhbnNfY2FwYWJsZV9ub2F1ZGl0KCZpbml0X3VzZXJfbnMsIENBUF9T
WVNfQURNSU4pKQogCQlyZXR1cm4gLUVQRVJNOwogCi0JZXJyID0gc2VjdXJpdHlfc2Jfc3RhdGZz
KG9yaWctPmRlbnRyeSk7Ci0JaWYgKGVycikKLQkJcmV0dXJuIGVycjsKKwlyZXQgPSBzZWN1cml0
eV9zYl9zdGF0ZnMob3JpZy0+ZGVudHJ5KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OwogCi0J
Zm9yIChjdHIgPSAwLCByID0gZmlyc3Q7IHIgJiYgY3RyIDwgYnVmc2l6ZTsgciA9IGxpc3RtbnRf
bmV4dChyKSkgeworCWZvciAocmV0ID0gMCwgciA9IGZpcnN0OyByICYmIG5lbnRyaWVzOyByID0g
bGlzdG1udF9uZXh0KHIpKSB7CiAJCWlmIChyLT5tbnRfaWRfdW5pcXVlID09IG1udF9pZCkKIAkJ
CWNvbnRpbnVlOwogCQlpZiAoIWlzX3BhdGhfcmVhY2hhYmxlKHIsIHItPm1udC5tbnRfcm9vdCwg
b3JpZykpCiAJCQljb250aW51ZTsKLQkJY3RyID0gYXJyYXlfaW5kZXhfbm9zcGVjKGN0ciwgYnVm
c2l6ZSk7Ci0JCWlmIChwdXRfdXNlcihyLT5tbnRfaWRfdW5pcXVlLCBidWYgKyBjdHIpKQorCQlp
ZiAocHV0X3VzZXIoci0+bW50X2lkX3VuaXF1ZSwgYnVmKSkKIAkJCXJldHVybiAtRUZBVUxUOwot
CQlpZiAoY2hlY2tfYWRkX292ZXJmbG93KGN0ciwgMSwgJmN0cikpCi0JCQlyZXR1cm4gLUVSQU5H
RTsKKwkJYnVmKyssIHJldCsrOyBuZW50cmllcy0tOwogCX0KLQlyZXR1cm4gY3RyOworCXJldHVy
biByZXQ7CiB9CiAKIFNZU0NBTExfREVGSU5FNChsaXN0bW91bnQsIGNvbnN0IHN0cnVjdCBtbnRf
aWRfcmVxIF9fdXNlciAqLCByZXEsCi0JCXU2NCBfX3VzZXIgKiwgYnVmLCBzaXplX3QsIGJ1ZnNp
emUsIHVuc2lnbmVkIGludCwgZmxhZ3MpCisJCXU2NCBfX3VzZXIgKiwgYnVmLCBzaXplX3QsIG5l
bnRyaWVzLCB1bnNpZ25lZCBpbnQsIGZsYWdzKQogewogCXN0cnVjdCBtbnRfbmFtZXNwYWNlICpu
cyA9IGN1cnJlbnQtPm5zcHJveHktPm1udF9uczsKIAlzdHJ1Y3QgbW50X2lkX3JlcSBrcmVxOwpA
QCAtNTExMSw3ICs1MTE0LDcgQEAgU1lTQ0FMTF9ERUZJTkU0KGxpc3Rtb3VudCwgY29uc3Qgc3Ry
dWN0IG1udF9pZF9yZXEgX191c2VyICosIHJlcSwKIAllbHNlCiAJCWZpcnN0ID0gbW50X2ZpbmRf
aWRfYXQobnMsIGxhc3RfbW50X2lkICsgMSk7CiAKLQlyZXQgPSBkb19saXN0bW91bnQoZmlyc3Qs
ICZvcmlnLCBtbnRfaWQsIGJ1ZiwgYnVmc2l6ZSwgJnJvb3QpOworCXJldCA9IGRvX2xpc3Rtb3Vu
dChmaXJzdCwgJm9yaWcsIG1udF9pZCwgYnVmLCBuZW50cmllcywgJnJvb3QpOwogZXJyOgogCXBh
dGhfcHV0KCZyb290KTsKIAl1cF9yZWFkKCZuYW1lc3BhY2Vfc2VtKTsK
--000000000000a535af060eb13163--

