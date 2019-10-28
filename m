Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7B0E7A6A
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 21:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbfJ1UpZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 16:45:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36291 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbfJ1UpY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 16:45:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id j22so1731336pgh.3
        for <linux-api@vger.kernel.org>; Mon, 28 Oct 2019 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KOjhDV2bOtkoryUtZNdedbIyz5aUvjz8VRxxdiXfCZg=;
        b=fcUjf9zk+4oJ62eLTSygNM/iUtrrnBl2+URBZKh9513ri3eVyRIWYt6bIgH6oBx4X0
         LB5TPZm0P2iY/11cju/J8f/fRgRBSAwMe0CVXk0tW/1XHV0t8T2PQd/ceyOdSMnCnni5
         9LeWRxiN2X+mhcgqmGe1cusQKUg8mFqlilKv2a9SwKST9Q/GowMmIwMwzcO2c2AGkhL4
         xKH5DOsYPndupfQyJrxwYB7Z09GUJSFWJ7UqrM1qLKEiwtJqH80kHN5F87HbqAbzaiMR
         uc5E7aoW6XA++r+uZ3QAikuJFPVAapX76VSsqSRNVeE3589Cdh9fCi9NV4M6qqamGUpI
         w21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KOjhDV2bOtkoryUtZNdedbIyz5aUvjz8VRxxdiXfCZg=;
        b=r+okW7s1fRtvaAv6pWFicGDnOtdYCwOPo0HFlDOXnkgHKLkDkoRApFe5K5L8U7JvXz
         EFXnaOJ7suzCqSSD9LA5bSFDtda2/IiQk0tTcc1y4K6n1FAvEvFYtsKhSvvMnfQfZ+nd
         2c3GnV/CnbLeW7todfwvL67Pd+6ch+96dZ4w49FGBFjpGXdvCeyTTzq+NdiZg+toEb1n
         Bl5c/CmzKkeI58GUPwaB7V1Pxca9Uy+GqJEcVubpERKhXe2F6igRtGVrbzTHB3qNX9Zq
         SmL5btoolYtFAmZSmXi6n9VmQJ9CH1f1iYXP/UEDg1E6WAUw+iNFxyRmHFEQ/gXv2rhA
         LhcA==
X-Gm-Message-State: APjAAAVUTxe2+iL18fhMqjjWtVHIykWJA/JEdl43VMdNquDDFZjDMjAl
        eYbKghgLQx211Q7WRhZVO0enoQ==
X-Google-Smtp-Source: APXvYqz+3RSrMew/VEEbk6rofjrWlXLaxsQq8rNZqiU1GY8aOt/v3M5nMsymLZnECmWFFPRlRADoVg==
X-Received: by 2002:a63:a03:: with SMTP id 3mr24167392pgk.112.1572295524109;
        Mon, 28 Oct 2019 13:45:24 -0700 (PDT)
Received: from [100.96.218.121] (241.sub-174-237-138.myvzw.com. [174.237.138.241])
        by smtp.gmail.com with ESMTPSA id l72sm372781pjb.18.2019.10.28.13.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 13:45:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
Date:   Mon, 28 Oct 2019 14:44:23 -0600
Message-Id: <CA5C22D9-BC3E-4B69-8DD9-4D3B75E40BD5@amacapital.net>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
In-Reply-To: <1572171452-7958-1-git-send-email-rppt@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Oct 27, 2019, at 4:17 AM, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> =EF=BB=BFFrom: Mike Rapoport <rppt@linux.ibm.com>
>=20
> Hi,
>=20
> The patch below aims to allow applications to create mappins that have
> pages visible only to the owning process. Such mappings could be used to
> store secrets so that these secrets are not visible neither to other
> processes nor to the kernel.
>=20
> I've only tested the basic functionality, the changes should be verified
> against THP/migration/compaction. Yet, I'd appreciate early feedback.

I=E2=80=99ve contemplated the concept a fair amount, and I think you should c=
onsider a change to the API. In particular, rather than having it be a MAP_ f=
lag, make it a chardev.  You can, at least at first, allow only MAP_SHARED, a=
nd admins can decide who gets to use it.  It might also play better with the=
 VM overall, and you won=E2=80=99t need a VM_ flag for it =E2=80=94 you can j=
ust wire up .fault to do the right thing.
