Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CA2917D4
	for <lists+linux-api@lfdr.de>; Sun, 18 Oct 2020 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJROP2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 18 Oct 2020 10:15:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42124 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJROP2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 18 Oct 2020 10:15:28 -0400
X-Greylist: delayed 4227 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 10:15:27 EDT
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kU8Mn-002Ipr-Dj; Sun, 18 Oct 2020 07:04:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kU8Mm-000424-0s; Sun, 18 Oct 2020 07:04:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>,
        containers@lists.linux-foundation.org,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Wat Lim <watl@google.com>, Mrunal Patel <mpatel@redhat.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, <linux-api@vger.kernel.org>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
        <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net>
        <874kmsdcdx.fsf@x220.int.ebiederm.org>
        <20201018102026.34jtxfheygowgejp@wittgenstein>
Date:   Sun, 18 Oct 2020 08:05:06 -0500
In-Reply-To: <20201018102026.34jtxfheygowgejp@wittgenstein> (Christian
        Brauner's message of "Sun, 18 Oct 2020 12:20:26 +0200")
Message-ID: <87h7qradml.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kU8Mm-000424-0s;;;mid=<87h7qradml.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/pyu37Trds5P/tpj4beDB1eRIcEN/AbrA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_XMDrugObfuBody_08,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 994 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.0%), b_tie_ro: 9 (0.9%), parse: 1.22 (0.1%),
         extract_message_metadata: 21 (2.1%), get_uri_detail_list: 4.3 (0.4%),
        tests_pri_-1000: 8 (0.8%), tests_pri_-950: 1.35 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 349 (35.1%), check_bayes:
        332 (33.4%), b_tokenize: 15 (1.5%), b_tok_get_all: 12 (1.3%),
        b_comp_prob: 4.0 (0.4%), b_tok_touch_all: 296 (29.8%), b_finish: 1.04
        (0.1%), tests_pri_0: 589 (59.2%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.70 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 8 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: The problem of setgroups and containers
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[ Added linux-api because we are talking about a subtle semantic
  change to the permission checks ]

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Sat, Oct 17, 2020 at 11:51:22AM -0500, Eric W. Biederman wrote:
>> "Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:
>> 
>> > On 30.08.20 16:39, Christian Brauner wrote:
>> >> For mount points
>> >>    that originate from outside the namespace, everything will show as
>> >>    the overflow ids and access would be restricted to the most
>> >>    restricted permission bit for any path that can be accessed.
>> >
>> > So, I can't just take a btrfs snapshot as rootfs anymore ?
>> 
>> Interesting until reading through your commentary I had missed the
>> proposal to effectively effectively change the permissions to:
>> ((mode >> 3) & (mode >> 6) & mode & 7).
>> 
>> The challenge is that in a permission triple it is possible to set
>> lower permissions for the owner of the file, or for a specific group,
>> than for everyone else.
>> 
>> Today we require root permissions to be able to map users and groups in
>> /proc/<pid>/uid_map and /proc/<pid>/gid_map, and we require root
>> permissions to be able to drop groups with setgroups.
>> 
>> Now we are discussiong moving to a world where we can use users and
>> groups that don't map to any other user namespace in uid_map and
>> gid_map.  It should be completely safe to use those users and groups
>> except for negative permissions in filesystems.  So a big question is
>> how do we arrange the system so anyone can use those files without
>> negative permission causing problems.
>> 
>> 
>> I believe it is safe to not limit the owner of a file, as the
>> owner of a file can always chmode the file and remove any restrictions.
>> Which is no worse than calling setuid to a different uid.
>> 
>> Which leaves where we have been dealing with the ability to drop groups
>> with setgroups.
>> 
>> I guess the practical proposal is when the !in_group_p and we are
>> looking at the other permission.  Treat the permissions as:
>> ((mode >> 3) & mode & 7).  Instead of just (mode & 7).
>> 
>> Which for systems who don't use negative group permissions is a no-op.
>> So this should not effect your btrfs snapshots at all (unless you use
>> negative group permissions).
>> 
>> It denies things before we get to an NFS server or other interesting
>> case so it should work for pretty much everything the kernel deals with.
>> 
>> Userspace repeating permission checks could break.  But that is just a
>> problem of inconsistency, and will always be a problem.
>> 
>> We could make it more precise as Serge was suggesting with a set of that
>> were dropped from setgroups, but under the assumption that negative
>> groups are sufficient rare we can avoid that overhead.
>
> I'm tempted to agree and say that it's safe to assume that they are used
> very much. Negative acls have been brought up a couple of times in
> related contexts though. One being a potential bug in newgidmap which we
> discussed back in
> https://bugs.launchpad.net/ubuntu/+source/shadow/+bug/1729357
> But I think if we have this under a sysctl as proposed earlier is good
> enough.
>
>> 
>>  static int acl_permission_check(struct inode *inode, int mask)
>>  {
>>  	unsigned int mode = inode->i_mode;
>>  
>> - [irrelevant bits of this function]        
>>  
>>  	/* Only RWX matters for group/other mode bits */
>>  	mask &= 7;
>>  
>>  	/*
>>  	 * Are the group permissions different from
>>  	 * the other permissions in the bits we care
>>  	 * about? Need to check group ownership if so.
>>  	 */
>>  	if (mask & (mode ^ (mode >> 3))) {
>>  		if (in_group_p(inode->i_gid))
>>  			mode >>= 3;
>> +		/* Use the most restrictive permissions? */
>> +		else (current->user_ns->flags & USERNS_ALWAYS_DENY_GROUPS)
>> +			mode &= (mode >> 3);
>>  	}
>>  
>>  	/* Bits in 'mode' clear that we require? */
>>  	return (mask & ~mode) ? -EACCES : 0;
>>  }
>> 
>> As I read posix_acl_permission all of the posix acls for groups are
>> positive permissions.  So I think the only other code that would need to
>> be updated would be the filesystems that replace generic_permission with
>> something that doesn't call acl_permission check.
>> 
>> Userspace could then activate this mode with:
>> 	echo "safely_allow" > /proc/<pid>/setgroups
>> 
>> That looks very elegant and simple, and I don't think will cause
>> problems for anyone.  It might even make sense to make that the default
>> mode when creating a new user namespace.
>> 
>> I guess we owe this idea to Josh Triplett and Geoffrey Thomas.
>> 
>> Does anyone see any problems with tweaking the permissions this way so
>> that we can always allow setgroups in a user namespace?
>
> This looks sane and simple. I would still think that making it opt-in
> for a few kernel releases might be preferable to just making it the new
> default. We can then revisit flipping the default. Advanced enough
> container runtimes will quickly pick up on this and can make it the
> default for their unprivileged containers if they want to.

I think we can even do a little bit better than what I proposed above.
The downside of my code is that negtative acls won't work in containers
even if they do today.  (Not that I think negative acls are something to
encourage just that breaking them means we have to deal with the
question: "Does someone care?").

What we can very safely do is limit negative acls to filesystems that
are mounted in the same user namespace.  Like the code below.

 static int acl_permission_check(struct inode *inode, int mask)
 {
 	unsigned int mode = inode->i_mode;
 
- [irrelevant bits of this function]        
 
 	/* Only RWX matters for group/other mode bits */
 	mask &= 7;
 
 	/*
 	 * Are the group permissions different from
 	 * the other permissions in the bits we care
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
 		if (in_group_p(inode->i_gid))
 			mode >>= 3;
+		/*
+		 * In a user namespace groups may have been dropped
+		 * so use the most restrictive permissions.
+		 */
+		else if (current->user_ns != inode->i_sb->user_ns)
+			mode &= (mode >> 3);
 	}
 
 	/* Bits in 'mode' clear that we require? */
 	return (mask & ~mode) ? -EACCES : 0;
 }

I would make the plan that we apply the fully fleshed out version of the
above (aka updating the permission methods that don't use
generic_permission), and then in a following kernel cycle we remove the
restrictions on setgroups because they are no longer needed.

The only possible user breaking issue I can see if a system with
negative acls where the containers rely on having access to the other
permissions for some reason.  If someone finds a system that does this
change would need to be reverted and another plan would need to be
found.  Otherwise I think/hope this is a safe semantic change.

Does anyone see any problems with my further simplification?

Eric
