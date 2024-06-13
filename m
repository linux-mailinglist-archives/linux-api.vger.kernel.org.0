Return-Path: <linux-api+bounces-1735-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA4907DE1
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2024 23:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF828465F
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2024 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEBB13BC03;
	Thu, 13 Jun 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="R8tQthge"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF431877;
	Thu, 13 Jun 2024 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313149; cv=none; b=aPWsCHCdSiaEWiNX9VcvWAKN0Sl4JsPQ3unlrS7UmMMY/5Pk0fgjcYfXuXgU4z6O1ftLDPjdRxtmPP1MM6Pk5pct9xV1sT0J09BZNcT5tKbWeXbLlf6QT1qa/sWSARAv1ku2j5OB0nvcydSKONCWKgQsSnIuIIQc1hf/QB+OGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313149; c=relaxed/simple;
	bh=UXIJthN/o7GeR55n4YXI3GvZNhMZOA4QaMAhUJy5rNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=InaxGJwHXMWC00fm1iQ1Jk/SkuNxkC2ZSWJ8iqwbdxQ2K3NyWeVNOyUson6eEQv+8RTZOc1i7bIajSbUgHNeMsGjJpRK+N4XzZyu70YvWZWIwmASWBw1M8DVXb4RWVR9gNFWEmWf5U22zf3MnBI6Xs/lk6ygkS/5vwnOzCWsMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=R8tQthge; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 594F23C00515C;
	Thu, 13 Jun 2024 14:12:21 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id NP8A1iB9-R08; Thu, 13 Jun 2024 14:12:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 0D60D3C005164;
	Thu, 13 Jun 2024 14:12:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 0D60D3C005164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1718313141;
	bh=YAX2QMf8kGApnxrDbPMNWh/cQR+fV5z58hC3Z9R6FhQ=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=R8tQthgeLdK3JTNn7cB3Usk63W8go9e7qexg759GrwOM8dgDqnUK+4ISi9k0OFxLN
	 rI/3nKj5aWI1WAraNK2zBop3Ho0XFxmOSubMtLkQ94VNI1EsipUnoTYD374eKDDDxS
	 /Hn/Ifwmq7kdwfdYADCqZ52eRhv/cxCB63dOpZidm7NV0xB9C7jyh9fJNvEJdCBOuX
	 /izMp07cuqGfh0MIvMwPZwnhnJ5B8nEX5XZ8/W6uSgeGYnuqvY+8z2ELx5i1wUupm6
	 ekdsFaOFHAL0K9ejLoKLKGr20aHjv1Ae9SYNUZFV3+tls8LFqQXx+QEHchZ3QGnjK2
	 aodeEwuKUKWCQ==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id AGcwdBeswR4G; Thu, 13 Jun 2024 14:12:20 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id DB0523C00515C;
	Thu, 13 Jun 2024 14:12:20 -0700 (PDT)
Message-ID: <6ce7434a-56bd-4e95-80f1-b2857834b0d4@cs.ucla.edu>
Date: Thu, 13 Jun 2024 14:12:20 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: termios constants should be unsigned
To: Zack Weinberg <zack@owlfolio.org>, Alejandro Colomar <alx@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org,
 GNU libc development <libc-alpha@sourceware.org>,
 'linux-man' <linux-man@vger.kernel.org>
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
 <f6ee2bd3-c1b7-4769-a313-b62f42c450ca@app.fastmail.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Autocrypt: addr=eggert@cs.ucla.edu; keydata=
 xsFNBEyAcmQBEADAAyH2xoTu7ppG5D3a8FMZEon74dCvc4+q1XA2J2tBy2pwaTqfhpxxdGA9
 Jj50UJ3PD4bSUEgN8tLZ0san47l5XTAFLi2456ciSl5m8sKaHlGdt9XmAAtmXqeZVIYX/UFS
 96fDzf4xhEmm/y7LbYEPQdUdxu47xA5KhTYp5bltF3WYDz1Ygd7gx07Auwp7iw7eNvnoDTAl
 KAl8KYDZzbDNCQGEbpY3efZIvPdeI+FWQN4W+kghy+P6au6PrIIhYraeua7XDdb2LS1en3Ss
 mE3QjqfRqI/A2ue8JMwsvXe/WK38Ezs6x74iTaqI3AFH6ilAhDqpMnd/msSESNFt76DiO1ZK
 QMr9amVPknjfPmJISqdhgB1DlEdw34sROf6V8mZw0xfqT6PKE46LcFefzs0kbg4GORf8vjG2
 Sf1tk5eU8MBiyN/bZ03bKNjNYMpODDQQwuP84kYLkX2wBxxMAhBxwbDVZudzxDZJ1C2VXujC
 OJVxq2kljBM9ETYuUGqd75AW2LXrLw6+MuIsHFAYAgRr7+KcwDgBAfwhPBYX34nSSiHlmLC+
 KaHLeCLF5ZI2vKm3HEeCTtlOg7xZEONgwzL+fdKo+D6SoC8RRxJKs8a3sVfI4t6CnrQzvJbB
 n6gxdgCu5i29J1QCYrCYvql2UyFPAK+do99/1jOXT4m2836j1wARAQABzSBQYXVsIEVnZ2Vy
 dCA8ZWdnZXJ0QGNzLnVjbGEuZWR1PsLBlQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AWIQR+N5Kp2Kz31jO8FYjtl+kOYqp+NAUCZiLOewUJHWQLDAAKCRDtl+kOYqp+NHGE
 D/9Wmbk+cAaQsYLPGBvyzIjZIRzo/V2p3ZwckVA1VEQivx5azu1cs86qDoVIe45AtwmKOvdV
 wTQd/QeglkZR6D2YPW7UR/7emajyJZZcy+etVTDKoaw1i6/hmd/CpGjUeUSvgoPs6nYR+1lo
 pSXTpaGrh1W0qQHalSkOOwCHG3HtGk9Ve2AERDUYxmcn8/eZHb7xpUJEJMBBI1bx/zcw1EtB
 rjsQ1R1faJ/r/7LPAyV36RLvnbX69PylHKQEbJoaY9aUb2Vpm63ni3FeTA7/3jpPvaSRWHJh
 vPYx6Fm2Ln8pI0Yf/W2B8QMiPTnF/LnH2kvUcf9VXm+1mQJ3fBFU25HZwBhuqZ24IeKymPEt
 BUMQAum97Dto0jSgR2OUvX7z+twhpQEgRGBzPHYwDi4SxF5Z4Q5Y7B7a++HP9tIxG6CVFIwI
 4xVaZud18bPa0YBL+cISmMgxq7h7yoVXl6u3pm9Yiv+W6Lp9QGN8Rw1VuJMOoFCYuoxG8mXO
 TA5b1jvlQ32gHFFhqErDAhNJRsfgrpe9Gok4Ycp+rWljbvS5Wrl0uth5MP7FbaHN2kmTZibq
 KXAd//IqczhDyU6qnW6ao+h4iDBDgYgRbQjmToX/vmIdEMzvPGqWXKhe/q1TYMuOO+IfP+bI
 fyPFH29nVN/o9c4J7myeKvv3HKSXdSVjlh2V787BTQRMgHJkARAApoXrvxP3DIfjCNOtXU/P
 dwMShKdX/RlSs5PfunV1wbKP8herXHrvQdFVqECaTSxmlhzbk8X0PkY9gcVaU2O49T3qsOd1
 cHeF52YFGEt0LhsBeMjgNX5uZ1V76r8gyeVlFpWWb0SIwJUBHrDXexF67upeRb2vdHBjYDNe
 ySn+0B7gFEqvVmZu+LadudDp6kQLjatFvHQHUSGNshBnkkcaTbiI9Pst0GCc2aiznBiPPA2W
 QxAPlPRh3OGTsn5THADmbjqY6FEMLasVX8DSCblMvLwNeO/8SxziBidhqLpJCqdQRWHku5Xx
 gIkGeKOz5OLDvXHWJyafrEYjjkS6Ak6B5z6svKliClWnjHQcjlPzyoFFgKTEfcqDxCj4RY0D
 0DgtFD0NfyeOidrSB/SzTe2hwryQE3rpSiqo+0cGdzh4yAHKYJ+UrXZ4p93ZhjGfKD1xlrNY
 DlWyW9PGmbvqFuDmiIAQf9WD/wzEfICc+F+uDDI+uYkRxUFp92ykmdhDEFg1yjYsU8iGU69a
 Hyvhq36z4zctvbqhRNzOWB1bVJ/dIMDvsExGcXQVDIT7sDNXv0wE3jKSKpp7NDG1oXUXL+2+
 SF99Kjy753AbQSAmH617fyBNwhJWvQYg+mUvPpiGOtses9EXUI3lS4v0MEaPG43flEs1UR+1
 rpFQWVHo1y1OO+sAEQEAAcLBfAQYAQgAJgIbDBYhBH43kqnYrPfWM7wViO2X6Q5iqn40BQJm
 Is58BQkdZAsMAAoJEO2X6Q5iqn40Q68QAJ9GubS/ej30Vc4idoZdc0IyMcL7kQJbMohF+Tyn
 ZE+TGn9WvzP10yLyzoI0vNlcNfP92d2MS//pFjOuANb5mwyiEYA+rDZIdS4ZZpHxCs2sxMC4
 afLCf3kv4aMnTeBvb9na403dlczz9cAacvsmniSFdpb1+BzMpYbybglU5oYMGhYT2nnCRjXN
 6S2nKYt4mjJeeOuxHrdeqQQdVBNYeNfTcPePeqvZ2+bD6u9yxZtaV+wxdpqglosQvjqhOYz7
 h50/ZTSq70/npoCq44TzdJKttaYvlW6ziRz0g4RRAqZyoxjYXiy5qj8r8zXJuB11ApZCGuKn
 /usbji9RYbflAhxFeh4LMmpDVi6BrF30b73Md59K7PuEKN1NxzlWiqqQHZZ9momN0GXLPcGq
 4uyfq7yVEy7wP5PMOh6oqscKklE3gFQtq0P1Ki0xqdF6Fq5LPJc+0Db2CYkVIy7Xaa/f74I3
 sOfQfEeDylVXR5iDfUJEYv/0DYhOr7q5/0b1kh3M4wkrB4C5jVNHjIIj+RsAK90c3t38OhAl
 jiSN7Bkwy24Afy8eIu6wWzvhnsQGpZPB+IffmxT1wkTy8UxZKjUWV0C82iphVgCUUi2f9sDV
 Q/tNcwVWmOS+gdv9Wk6tdGeM+Ee+Qs6YG05jcSoajzF0TL07ajLcayRq2j1Os2CtQ8qu
Organization: UCLA Computer Science Department
In-Reply-To: <f6ee2bd3-c1b7-4769-a313-b62f42c450ca@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:32, Zack Weinberg wrote:
> there is still a need for
> caution around conversions that change signedness.

Yes, just as there is need for caution around any use of unsigned types. 
Unfortunately in my experience Clang's (and even GCC's) warnings about 
signedness conversion are more likely to cause harm than good, with this 
thread being an example of the harm.

Part of the issue here is that GCC and Clang often do a better job of 
warning when constants are signed, not unsigned. For example, suppose a 
program mistakenly packages termios flags along with three other bits 
into an 'unsigned long', with code like this:

   unsigned long
   tagged_pendin (unsigned tag)
   {
     return (PENDIN << 3) | tag;
   }

Since PENDIN is 0x20000000 Clang and GCC by default warn about the 
mistake, as the signed integer overflow has undefined behavior. But if 
PENDIN were changed to 0x20000000U the behavior would be well-defined, 
there would be no warning even with -Wall -Wextra -Wsign-conversion, and 
the code would silently behave as if PENDIN were zero, which is not 
intended.

This is another reason why appending "U" to PENDIN's value would have 
drawbacks as well as advantages.


