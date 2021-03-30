Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1234EEE4
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhC3RC3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Mar 2021 13:02:29 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:40680 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhC3RBT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 13:01:19 -0400
Received: by mail-ej1-f48.google.com with SMTP id u9so25874402ejj.7;
        Tue, 30 Mar 2021 10:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACAk4CMQCpfK7ShWMIgNHXJw2kj1X4hF0oXL0+B1bYU=;
        b=GdleGBszUcIxMc8Fp1BZGjq2pMexJr5m3KcCTf4vqvZRFSBQibZmt9mfRi52kcVMvg
         Vif8/oWxlsGqN96Gh4+1xDw66NozAmO9lrDDsVXs9Q9ZTA4oWy2LcaVOy2CIBeN+CWIX
         CM6mRmli3imKMq7j2FhlM2z+RAUDWkOvRnCp3IDLhb5nE6jiSV6QagurUzm2L6INEjEf
         CrfwBZRb6yo1Ilu08oiVNCY4tcG+Sbdv2Hi5gNBQkRx/vuXRJ0nBDw5XaFmK8efOVrBo
         5Ivv4Y8nOEJD78qAuawBDb67ejam1dGG+2C6+x1tR1f7GUj6nRkB2lg996YaSv8fCCJ5
         oW2g==
X-Gm-Message-State: AOAM531J5uhxnNxapacZmXlhZxoxN/9+a0s/8lExeifR4dSZcI3ynHjh
        1OliB+JfI7VrOccgzk552fDkrSeqqzckMTmZGB0=
X-Google-Smtp-Source: ABdhPJy5avb4gakhkfdjDLmEHbWWFLQIdzjxvPZMkVANXhrKi4DUV+nFsseKQB12c8SuGUmn48M6dP+J0Nxset5CnpI=
X-Received: by 2002:a17:906:340f:: with SMTP id c15mr21662769ejb.317.1617123677867;
 Tue, 30 Mar 2021 10:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
 <5F98327E-8EC4-455E-B9E1-74D2F13578C5@amacapital.net> <CAJvTdKkP=A4+gOoa+pDwinBf=dBKpe9=_ZFcpx_cFWjqG3p-XQ@mail.gmail.com>
 <CALCETrV_sQnu0u+wKZrAL2-500EHoQ6d4LgRhCWwRhK-4Z3X7A@mail.gmail.com>
In-Reply-To: <CALCETrV_sQnu0u+wKZrAL2-500EHoQ6d4LgRhCWwRhK-4Z3X7A@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 30 Mar 2021 13:01:06 -0400
Message-ID: <CAJvTdKmQN7dXk7FifOqZRZRrOqOoB_6+VR9ORx_AfZWpVRePdA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andy,

I agree, completely, with your description of the challenge,
thank you for focusing the discussion on that problem statement.

Question:

Is it required (by the "ABI") that a user program has everything
on the stack for user-space XSAVE/XRESTOR to get back
to the state of the program just before receiving the signal?

My understanding is that there are programs that do this.
However, if it is not guaranteed to work, that could greatly simplify
what we are required to put on the signal stack.

thanks,
-Len
