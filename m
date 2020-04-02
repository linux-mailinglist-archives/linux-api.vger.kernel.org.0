Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197BF19CABF
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 22:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgDBUHN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 16:07:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40005 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBUHN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 16:07:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id r19so4850517otn.7;
        Thu, 02 Apr 2020 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUFtmlg41TuJZV8AFeY3Ax8m5WV2BnHwD1DxS40jxDc=;
        b=kYUERnsRHs56p2QVEoIlDkQcC6o89BTpcya+rHIELnNtnMQzijMzAv39fkH1G6ovDi
         lyzY1dwhW+e2u2SUc6un6ZUXs6g5HD7yhfpZ567vM40Y4evQgUcvNQSrqm1Gxq5TW5SM
         aqsLGFbxrERC76+MKL1y9ElaF7h8usmZggMDJbSaIG9+U0WK0ElZD68jfJZ1TJsL4GBY
         11zShgmNLF7L4xs2XfgLQRwNTW7GI4JhHyJV1+/2M7uNPlVMmt03Tuw5LSLLU0jGZFv6
         18LIWLZe6izLRr5onQN47yPDw3Q5P1hiS+MkHzF66pLSFsRHSoox/xQGE0A8tfqV4o/d
         ecfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUFtmlg41TuJZV8AFeY3Ax8m5WV2BnHwD1DxS40jxDc=;
        b=c6CiBwBFVHCRyFAC77jcKYdPXIU+7y5Ec3U51YeNBDpco5DayXgwoFHbHs+3MNRzRO
         NdYoDXGdV24QPSvifjuZDVnaQE0mMCLhaWYWLxhnBWaGByiAM+eAGpAAv+4lR9NrvQZS
         cMI0OAQo5ceAdZzStA3dJ3mtm9gHnN4s9cCjBUukc0O0f5nAc9T2MV1MlEdl7yg1PI4I
         IxZm/+3sHmxZUvJB5iV80qTQ5hicSzm4kH47qDZsVS+jprzf+lg682GvlNUdp/BBNLql
         zy+tks2ShYQa5qIF/lkXARzr2KdS9g0XVoP7G9A4INBUnTTuDa00basYRIrkBv4osHBn
         tiiA==
X-Gm-Message-State: AGi0Pua+l5kYt6zNqmRdW9TPTHwbtiVhzckDgpXoYpl9cxmPi0bFFwwR
        WFrWYgMFM9ZlmwkIHKIslHZFAMpuRYIeZ6ftChU=
X-Google-Smtp-Source: APiQypLkjZPAMQazKF1lzyj9LHkXuX85vsXZmIePxxBonv771twBMPyGUkjMIXSkvuQLMJzJTFGzvrNj0vVSLEKvM94=
X-Received: by 2002:a05:6830:1d95:: with SMTP id y21mr3937189oti.180.1585858032155;
 Thu, 02 Apr 2020 13:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
In-Reply-To: <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Thu, 2 Apr 2020 13:06:59 -0700
Message-ID: <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     Eric Rannaud <e@nanocritical.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Micheal,

I'm conscious that saying "dynamic POSIX clock device" without any
explanation may be too obscure for a man page.

There is documentation in:
- include/linux/posix-clock.h
- Documentation/driver-api/ptp.rst (explicitly states that EOPNOTSUPP
should be returned)
- include/uapi/linux/ptp_clock.h

(IEEE 1588 PTP is the canonical user of these dynamic clock devices)

Would you want to refer to any of these from the man page?

Thanks for maintaining this project!
Eric

On Thu, Apr 2, 2020 at 7:24 AM Eric Rannaud <e@nanocritical.com> wrote:
>
> See Linux source as of v5.4:
>   kernel/time/posix-clock.c
>
> Signed-off-by: Eric Rannaud <e@nanocritical.com>
> ---
>  man2/clock_getres.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/man2/clock_getres.2 b/man2/clock_getres.2
> index 0154f9d32473..71f7f8dfa662 100644
> --- a/man2/clock_getres.2
> +++ b/man2/clock_getres.2
> @@ -260,6 +260,10 @@ specified in a call to
>  .BR clock_settime ()
>  is not a settable clock.
>  .TP
> +.B EOPNOTSUPP
> +The operation is not supported by the dynamic POSIX clock device
> +specified.
> +.TP
>  .BR EINVAL " (since Linux 4.3)"
>  .\" commit e1d7ba8735551ed79c7a0463a042353574b96da3
>  A call to
> @@ -276,6 +280,11 @@ clock.
>  .B EPERM
>  .BR clock_settime ()
>  does not have permission to set the clock indicated.
> +.TP
> +.B EACCES
> +.BR clock_settime ()
> +does not have write permission for the dynamic POSIX
> +clock device indicated.
>  .SH VERSIONS
>  These system calls first appeared in Linux 2.6.
>  .SH ATTRIBUTES
> --
> 2.26.0
>
