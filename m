Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9E9112E
	for <lists+linux-api@lfdr.de>; Sat, 17 Aug 2019 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfHQPRC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Sat, 17 Aug 2019 11:17:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42743 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQPRC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Aug 2019 11:17:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id j7so12256212ota.9
        for <linux-api@vger.kernel.org>; Sat, 17 Aug 2019 08:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:reply-to:to:cc:from
         :message-id;
        bh=cpFWvwTyaPqXRIX+olha7zRUYs7a4m4MAPJ3m6v++V0=;
        b=NSiHP8qbyhgKYOrcshk7uilg1Z8stuujNbDGtqKpwhMCaYS1xwhxKJAbrpuVbVtTvS
         mv31+E+aNItJ8zasDn5+bxUSrc9KN/8nXEzTGJu/PGYc6/Z3l30htT0SbaUC2Nx38NeE
         PPR4GPqFeTvSh6q+QPTQV9GIRkJXcx4PWZitfKZCQJftOjjp8Q3cp/pYi08AWxB3n/II
         lVfyNdjI70a9EGJjgzw7Ljpfk9vSEg8RIP6I3t6a9GtZazJwEfWEe8M+U7ib0zzRdLK7
         aWe3m2q7tjoYmdvxwf/J5bHZG6fTShAgFUDXJQsScfPrVAnIvclWbrG448XGoRZPdaUP
         qsVQ==
X-Gm-Message-State: APjAAAXX5v9aZm0+2FNw9SF5ARlpw6N/6X17qcuZJ4qDqsB+44Kn/L4v
        f+QVufN1B/roHTkhlxIFW0afIQ==
X-Google-Smtp-Source: APXvYqw4l4xTDH+aNPNyx9ObDfyDr9k3gM1hAyk4DI8BIHqbWxyX1iUnHyBA3UaEXCn3Th/gsJbS8g==
X-Received: by 2002:a05:6830:1015:: with SMTP id a21mr6496014otp.232.1566055021174;
        Sat, 17 Aug 2019 08:17:01 -0700 (PDT)
Received: from [26.82.211.143] ([172.56.7.81])
        by smtp.gmail.com with ESMTPSA id k16sm1939733otj.58.2019.08.17.08.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 08:17:00 -0700 (PDT)
Date:   Sat, 17 Aug 2019 17:16:53 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190817150843.4vsmzpwpcvzndjld@ast-mbp>
References: <20190805192122.laxcaz75k4vxdspn@ast-mbp> <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com> <20190806011134.p5baub5l3t5fkmou@ast-mbp> <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com> <20190813215823.3sfbakzzjjykyng2@ast-mbp> <201908151203.FE87970@keescook> <20190815234622.t65oxm5mtfzy6fhg@ast-mbp.dhcp.thefacebook.com> <B0364660-AD6A-4E5C-B04F-3B6DA78B4BBE@amacapital.net> <20190816214542.inpt6p655whc2ejw@ast-mbp.dhcp.thefacebook.com> <20190816222252.a7zizw7azkxnv3ot@wittgenstein> <20190817150843.4vsmzpwpcvzndjld@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
Reply-to: christian.brauner@ubuntu.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <61B88085-9FBB-41E6-9783-324E445E428D@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On August 17, 2019 5:08:45 PM GMT+02:00, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>On Sat, Aug 17, 2019 at 12:22:53AM +0200, Christian Brauner wrote:
>> 
>> (The one usecase I'd care about is to extend seccomp to do
>pointer-based
>> syscall filtering. Whether or not that'd require (unprivileged) ebpf
>is
>> up for discussion at KSummit.)
>
>Kees have been always against using ebpf in seccomp. I believe he still
>holds this opinion. Until he changes his mind let's stop bringing
>seccomp
>as a use case for unpriv bpf.

That's why I said "whether or not".
For the record, I do prefer a non-unpriv-ebpf way.
It's still something that will most surely come up in the discussion though.
