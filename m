Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11C35A68D
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 23:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF1Vtf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Jun 2019 17:49:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39228 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF1Vtf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Jun 2019 17:49:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so3627421pfe.6
        for <linux-api@vger.kernel.org>; Fri, 28 Jun 2019 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qdZrjeoDNSQsqkyJp6BkgnYTQ7c4BAmADlCHRSbPn3o=;
        b=Jbtf3SMdEjxfXc+d5F8QO1cas1KV2BV1hoJs1qRKJoPwT1GlFe/aVrIguqs8TeA5WL
         XFjSvXz5JL1mUxkp/yO9dDhKS2J+SdrJ0lxayg7atN068yg4GTjfLZEsHH6mtervlgTu
         dfdYK9wPBB2jWUqrgrGm8vXuRpOQ+u1Yc96OVeVo3XhBxIwOapG0VhV1rN1dM/PdL3/X
         bn1SdNRys1EYpFylxcnIXF3WzYpVDimXTzieLOZngZ+kqn3ePeZflspOP3g1t7V/TKhT
         bcyf3c/YjSwa+06KGllNZms+B+F87dwMlPa8OT/AmVRI2aAmsjsl+ygOc4phTxqIL3Hv
         VbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qdZrjeoDNSQsqkyJp6BkgnYTQ7c4BAmADlCHRSbPn3o=;
        b=n7dqdUA4dA7eWgE9ZvchMEAMSKoTpDswkmlITJsTX+tfNlzDRo451k70EdhPn3guKQ
         pdmlLkdDDRO8xIy8B7Q20ZbEpNoETf9tYZxKNI3ri/90cS68jY3yNezwl2byr1sG3d4b
         tJO/NRAuz5xq4a6ViUKPopXAZQZIOletzbCuOOZTnnMDSAw26SF63xgmaQgkqcQFfKjH
         mAkLFshbTOhCYS+aDTmYaiylJ1hwJ5I9IT9xAH7c7EUduiRkKRysI1FnvcAoIGC8/p+v
         WtLQVq2/QlzqHEuwHuX/65lT+n+aPKl7d6SCupvr9Ped6U9RzWqYF5Xh1/qRg1AgPweR
         L3ZA==
X-Gm-Message-State: APjAAAVmFeaj/3I6V6act9cW0KLKFD7xuEOzMmPjRw1XjZ1HQbJhS6Yd
        cJmtvAvso88adTgb/iY4u5OAcA==
X-Google-Smtp-Source: APXvYqz/YPDWsT7hhTRb2Bm2QEJ3v+KaME0sQBT1mNpk1MmCdOSSpZuy1ArM2RVKH8r8EsILBD1Myg==
X-Received: by 2002:a17:90a:c504:: with SMTP id k4mr15615755pjt.104.1561758574932;
        Fri, 28 Jun 2019 14:49:34 -0700 (PDT)
Received: from ?IPv6:2600:1010:b00c:70fb:70e6:7ca0:457a:d080? ([2600:1010:b00c:70fb:70e6:7ca0:457a:d080])
        by smtp.gmail.com with ESMTPSA id d123sm3359464pfc.144.2019.06.28.14.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 14:49:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/3] mm: Introduce VM_IBT for CET legacy code bitmap
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190628194158.2431-1-yu-cheng.yu@intel.com>
Date:   Fri, 28 Jun 2019 14:49:32 -0700
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBB8C19E-7F65-4D43-9783-6383478700A1@amacapital.net>
References: <20190628194158.2431-1-yu-cheng.yu@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Jun 28, 2019, at 12:41 PM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
> The previous discussion of the IBT legacy code bitmap is here:
>=20
>    https://lkml.org/lkml/2019/6/6/1032
>=20
> When CET Indirect Branch Tracking (IBT) is enabled, the processor expects
> every branch target is an ENDBR instruction, or the target's address is
> marked as legacy in the legacy code bitmap.  The bitmap covers the whole
> user-mode address space (TASK_SIZE_MAX for 64-bit, TASK_SIZE for IA32),
> and each bit represents one page of linear address range.
>=20
> This patch introduces VM_IBT for the bitmap.

There=E2=80=99s no need to allocate a bit for this and to clutter up the fau=
lt code with special cases. Use _install_special_mapping(), please.  If you n=
eed to make it more flexible to cover your use case, please do so.

