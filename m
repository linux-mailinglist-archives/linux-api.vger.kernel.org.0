Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B378214CD0A
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgA2POr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 10:14:47 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40316 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgA2POr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 10:14:47 -0500
Received: by mail-lj1-f180.google.com with SMTP id n18so18833566ljo.7
        for <linux-api@vger.kernel.org>; Wed, 29 Jan 2020 07:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A86ktnaGthgQnU7BZkhQofq1ezZpSuArhDRStbyXDng=;
        b=qyT/BivTXG6qNnpNQ5ufeDtin4S3iRXB/70Yriqqs6UW3y3gcV6G+0Ym3n7nqeOk8B
         jFC56xW8kawnlKQF57ipz4XUtv6XhcwMswbuSl34p4kfF73dSJZMKI00L14h91xepLz9
         pvgFR5trdohez+rdk19St0IB3O3dRoYE7BtdhtiS3nTH59KnNodJ9crpZ0Akpvo7JS8S
         T2JLtONfBDLg6cFD7oIQF4nYqbxfkYLvacbXRD/xn6LjLV1A3tLy2AYYOy3vHXROsq7w
         +p+Ps++8x6HhCnF4uEpNw+g0k4LDnSbwYbIFjRmug/6nZ+E+K8Mk7BrTR/X09BQVNWko
         Na3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A86ktnaGthgQnU7BZkhQofq1ezZpSuArhDRStbyXDng=;
        b=UvSreXwSpGnMIQJ7YGU1LLfo3Hh9HVJ1tnJkTrY0vD9aSAxhoLtQ4V+Nn8QPc0f+dX
         gsYyYNysU2DtMt1D0tkGs5Chigdx63kCxgxADlVHSQW1yRx5ieAakBwBaedlaT3pwbF7
         yLwFNUR7W9Kl6H73noO0Gc8DGb2w568OlDOUZH2hy7kSzC7vgtw1d5uREU+a8MwYYPtk
         +yStg3Mr5W3Dp6T+UWqE/SViJhRIMf+tP21mMf1i1erTk+x7wXVYmStx8rw73V573NxQ
         lfCfikIEzdEPJJctXnQc9LSj1KgeY0CoePWqGe1zCqeNJyj1rnDK4P5POD5aM1aOENeG
         0mjg==
X-Gm-Message-State: APjAAAUdmjn8q1bWprGbJiLlP1UEjql2/j8Z1sivNJPXGnr/57OT8WTQ
        PBW22sdDxcwEA1BWB1E2KkghDi0KEYLP2JahLWoKmvn6sQQ=
X-Google-Smtp-Source: APXvYqzjfO/YqqHqe9HnZ8e2uiFnZm7ExueSBY+rJP6a4lQ5DJxJQgJBknWIbra+2sbPcjbjPaNBeUBRVcFmInn2WQ0=
X-Received: by 2002:a2e:b68c:: with SMTP id l12mr16148520ljo.36.1580310885018;
 Wed, 29 Jan 2020 07:14:45 -0800 (PST)
MIME-Version: 1.0
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Wed, 29 Jan 2020 17:14:18 +0200
Message-ID: <CALN7hC+f+D8xsaJBt+MCXDfk51oHCoQeUVmFydNdkW+_DeqTiw@mail.gmail.com>
Subject: Including both linux/time.h and linux/input.h causes failure
To:     linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,
The following header: <wrapper.h>:
```
#include <linux/input.h>
#include <linux/time.h>
```
Will cause the compiler to fail because of redefinition of a lot of
time related structs, that are declared once in `linux/time.h` and
then again via `bits/types/struct_timeval.h` which is included through
`linux/input.h > sys/time.h -> bits/types/struct_timeval.h`



Command: `gcc -I./headers_install/x86/include wrapper.h`
output:
```
In file included from wrapper.h:13:
./headers_install/x86/include/linux/time.h:16:8: error: redefinition
of =E2=80=98struct timeval=E2=80=99
   16 | struct timeval {
      |        ^~~~~~~
In file included from /usr/include/sys/time.h:25,
                 from ./headers_install/x86/include/linux/input.h:13,
                 from wrapper.h:8:
/usr/include/bits/types/struct_timeval.h:8:8: note: originally defined here
    8 | struct timeval
      |        ^~~~~~~
In file included from wrapper.h:13:
./headers_install/x86/include/linux/time.h:21:8: error: redefinition
of =E2=80=98struct timezone=E2=80=99
   21 | struct timezone {
      |        ^~~~~~~~
In file included from ./headers_install/x86/include/linux/input.h:13,
                 from wrapper.h:8:
/usr/include/sys/time.h:52:8: note: originally defined here
   52 | struct timezone
      |        ^~~~~~~~
In file included from wrapper.h:13:
./headers_install/x86/include/linux/time.h:30: warning: "ITIMER_REAL" redef=
ined
   30 | #define ITIMER_REAL  0
      |
In file included from ./headers_install/x86/include/linux/input.h:13,
                 from wrapper.h:8:
/usr/include/sys/time.h:92: note: this is the location of the previous
definition
   92 | #define ITIMER_REAL ITIMER_REAL
      |
In file included from wrapper.h:13:
./headers_install/x86/include/linux/time.h:31: warning:
"ITIMER_VIRTUAL" redefined
   31 | #define ITIMER_VIRTUAL  1
      |
In file included from ./headers_install/x86/include/linux/input.h:13,
                 from wrapper.h:8:
/usr/include/sys/time.h:95: note: this is the location of the previous
definition
   95 | #define ITIMER_VIRTUAL ITIMER_VIRTUAL
      |
In file included from wrapper.h:13:
./headers_install/x86/include/linux/time.h:32: warning: "ITIMER_PROF" redef=
ined
   32 | #define ITIMER_PROF  2
      |
In file included from ./headers_install/x86/include/linux/input.h:13,
                 from wrapper.h:8:
/usr/include/sys/time.h:99: note: this is the location of the previous
definition
   99 | #define ITIMER_PROF ITIMER_PROF
      |
In file included from wrapper.h:13:
./headers_install/x86/include/linux/time.h:39:8: error: redefinition
of =E2=80=98struct itimerval=E2=80=99
   39 | struct itimerval {
      |        ^~~~~~~~~
In file included from ./headers_install/x86/include/linux/input.h:13,
                 from wrapper.h:8:
/usr/include/sys/time.h:104:8: note: originally defined here
  104 | struct itimerval
      |        ^~~~~~~~~

```

--=20
PGP: 5607C93B5F86650C
